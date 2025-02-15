//
//  MovieListPresenter.swift
//  movie-app
//
//  Created by Robusta on 12/02/2025.
//

import Foundation

class MovieListPresenter {
    weak var view: MovieListView?
    var isViewingSearchResults: Bool = false
    private let fetchMoviesUseCase: FetchMoviesUseCase
    private let searchMoviesUseCase: SearchMoviesUseCase
    private var popularMovies: [Movie] = []
    private var groupedMovies: [String: [MovieEntity]] = [:]
    private var sortedSections: [String] = []
    
    private var currentPage = 1
    private var totalPages = 1
    private var isLoading = false
    
    init(view: MovieListView, fetchMoviesUseCase: FetchMoviesUseCase, searchMoviesUseCase: SearchMoviesUseCase) {
        self.view = view
        self.fetchMoviesUseCase = fetchMoviesUseCase
        self.searchMoviesUseCase = searchMoviesUseCase
    }
    
    func numberOfSections() -> Int {
        return sortedSections.count
    }
    
    func titleForSection(_ section: Int) -> String {
        return sortedSections[section]
    }
    
    func numberOfRows(in section: Int) -> Int {
        let key = sortedSections[section]
        return groupedMovies[key]?.count ?? 0
    }
    
    func configure(for cell: MovieListCell, at indexPath: IndexPath) {
        let movieEntity = movie(at: indexPath)
        cell.display(movieInfo: movieEntity)
    }
    
    

    func loadMovies() {
        guard !isLoading, currentPage <= totalPages else { return }
        isLoading = true

        fetchMoviesUseCase.execute(page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false

                switch result {
                case .success(let moviesResponse):
                    let movieEntities = (moviesResponse.results ?? []).map { $0.toMovieEntity() }
                    
                    // Append movies to the existing list
                    self.popularMovies.append(contentsOf: moviesResponse.results ?? [])
                    self.groupMoviesByYear(movieEntities)
                    
                    self.totalPages = moviesResponse.totalPages ?? 1
                    self.currentPage += 1
                    
                    self.view?.reloadTableView()
                    
                case .failure(let error):
                    self.view?.displayError(error.localizedDescription)
                }
            }
        }
    }
    
    func loadMoreMoviesIfNeeded(at indexPath: IndexPath) {
        let key = sortedSections[indexPath.section]
        if let moviesInSection = groupedMovies[key], indexPath.row == moviesInSection.count - 1 {
            loadMovies()
        }
    }
    
    func searchMovies(with keyword: String) {
        guard !keyword.isEmpty else { return }
        searchMoviesUseCase.execute(searchKeyword: keyword) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    let movieEntities = (movies.results ?? []).map { $0.toMovieEntity() }
                    self?.groupMoviesByYear(movieEntities)
                    self?.view?.reloadTableView()
                    self?.isViewingSearchResults = true
                case .failure(let error):
                    self?.view?.displayError(error.localizedDescription)
                }
            }
        }
    }
    
    func didSelectMovie(at indexPath: IndexPath) {
        guard let movieId = movie(at: indexPath).id else { 
            self.view?.displayError("can't find this movie")
            return }
        view?.navigateToMovieDetails(movieId: movieId)
    }
    
    func movie(at indexPath: IndexPath) -> MovieEntity {
        let key = sortedSections[indexPath.section]
        return groupedMovies[key]![indexPath.row]
    }
    
    func searchBarCleared() {
        if isViewingSearchResults {
            let movieEntities = (popularMovies).map { $0.toMovieEntity() }
            groupMoviesByYear(movieEntities)
            view?.reloadTableView()
            self.isViewingSearchResults = false
        }
    }
    
    func handleWatchlistOperations(at indexPath: IndexPath, for cell: MovieListCell) {
        var pendingMovie = movie(at: indexPath)
        let key = sortedSections[indexPath.section]
        
        if (pendingMovie.isInWatchlist ?? false) {
            UserUtilities.removeFromWatchlist(movieID: pendingMovie.id ?? 0)
            pendingMovie.isInWatchlist = false
        } else {
            UserUtilities.addToWatchlist(movieID: pendingMovie.id ?? 0)
            pendingMovie.isInWatchlist = true
        }
        groupedMovies[key]![indexPath.row] = pendingMovie
        cell.setWatchlistButton(for: pendingMovie.isInWatchlist ?? false)
        
    }
    
    func resetMovieEntities() {
        let movieEntities = (popularMovies).map { $0.toMovieEntity() }
        groupMoviesByYear(movieEntities)
        self.view?.reloadTableView()
    }
    
    // Private Helpers
    private func groupMoviesByYear(_ movies: [MovieEntity]) {
        var tempGroupedMovies = groupedMovies // Preserve previous results

        for movie in movies {
            if let date = movie.formattedReleaseDate {
                let year = Calendar.current.component(.year, from: date)
                let yearString = "\(year)"
                
                if tempGroupedMovies[yearString] == nil {
                    tempGroupedMovies[yearString] = []
                }
                tempGroupedMovies[yearString]?.append(movie)
            }
        }
        
        self.groupedMovies = tempGroupedMovies
        self.sortedSections = tempGroupedMovies.keys.sorted(by: { $0 > $1 })
    }
    
}
