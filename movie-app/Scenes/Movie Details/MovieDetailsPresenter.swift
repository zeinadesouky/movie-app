//
//  MovieDetailsPresenter.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import Foundation

class MovieDetailsPresenter {
    weak var view: MovieDetailsView?
    private let fetchMovieDetailsUseCase: FetchMovieDetailsUseCase
    private let movieId: Int?
    
    init(view: MovieDetailsView, fetchMovieDetailsUseCase: FetchMovieDetailsUseCase, movieId: Int) {
        self.view = view
        self.fetchMovieDetailsUseCase = fetchMovieDetailsUseCase
        self.movieId = movieId
    }
    
    func loadMovieDetails() {
        guard let movieId else { return }
        self.view?.loadDetailsView()
        fetchMovieDetailsUseCase.execute(movieId: movieId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movie):
                    self?.view?.display(movieInfo: movie)
                    self?.view?.hideDetailsViewLoader()
                case .failure(let error):
                    self?.view?.displayError(error.localizedDescription)
                    self?.view?.hideDetailsViewLoader()
                }
            }
        }
    }
    
    func handleWatchlistOperations() {
        if UserUtilities.loadWatchlist().contains(where: {$0 == movieId}) {
            UserUtilities.removeFromWatchlist(movieID: movieId ?? 0)
        } else {
            UserUtilities.addToWatchlist(movieID: movieId ?? 0)
        }
        view?.setWatchlistButton(for: UserUtilities.loadWatchlist().contains(where: {$0 == movieId}))
    }
}
