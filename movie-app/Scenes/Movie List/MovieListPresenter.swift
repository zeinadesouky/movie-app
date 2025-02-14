//
//  MovieListPresenter.swift
//  movie-app
//
//  Created by Robusta on 12/02/2025.
//

import Foundation

class MovieListPresenter {
    weak var view: MovieListView?
    private let fetchMoviesUseCase: FetchMoviesUseCase
    private var groupedMovies: [String: [MovieEntity]] = [:]
    private var sortedSections: [String] = []
    
    init(view: MovieListView, fetchMoviesUseCase: FetchMoviesUseCase) {
        self.view = view
        self.fetchMoviesUseCase = fetchMoviesUseCase
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
        fetchMoviesUseCase.execute { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    let movieEntities = (movies.results ?? []).map { $0.toMovieEntity() }
                    self?.groupMoviesByYear(movieEntities)
                    self?.view?.reloadTableView()
                case .failure(let error):
                    self?.view?.displayError(error.localizedDescription)
                }
            }
        }
    }
    
    func didSelectMovie(at indexPath: IndexPath) {
        let movie = movie(at: indexPath)
        view?.navigateToMovieDetails(movie: movie)
    }
    
    func movie(at indexPath: IndexPath) -> MovieEntity {
        let key = sortedSections[indexPath.section]
        return groupedMovies[key]![indexPath.row]
    }
    
    // Private Helpers
    private func groupMoviesByYear(_ movies: [MovieEntity]) {
        var tempGroupedMovies: [String: [MovieEntity]] = [:]
        
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
