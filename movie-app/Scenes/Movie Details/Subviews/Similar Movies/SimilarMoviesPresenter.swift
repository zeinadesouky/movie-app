//
//  SimilarMoviesPresenter.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import Foundation

class SimilarMoviesPresenter {
    weak var view: SimilarMoviesView?
    private let fetchSimilarMoviesUseCase: FetchSimilarMoviesUseCase
    private let movieId: Int?
    private var similarMovies: [Movie] = []
    
    init(view: SimilarMoviesView, fetchSimilarMoviesUseCase: FetchSimilarMoviesUseCase, movieId: Int) {
        self.view = view
        self.fetchSimilarMoviesUseCase = fetchSimilarMoviesUseCase
        self.movieId = movieId
    }
    
    func rowsInSection(section: Int) -> Int {
         min(similarMovies.count, 5)
    }
    
    func configure(cell: SImilarMovieCell, at indexPath: IndexPath) {
        let movie = similarMovies[indexPath.row]
        cell.configure(movie: movie)
    }
    
    func loadSimilarMovies() {
        guard let movieId else { return }
        self.view?.showContainerLoader()
        fetchSimilarMoviesUseCase.execute(movieId: movieId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.similarMovies = movies.results ?? []
                    self?.view?.hideContainerLoader()
                    self?.view?.reloadCollectionView()
                case .failure(let error):
                    self?.view?.displayError(error.localizedDescription)
                    self?.view?.hideContainerLoader()
                }
            }
        }
    }
}
    
