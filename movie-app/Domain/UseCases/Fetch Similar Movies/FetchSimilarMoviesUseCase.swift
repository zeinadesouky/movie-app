//
//  FetchSimilarMoviesUseCase.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import Foundation

protocol FetchSimilarMoviesUseCase {
    func execute(movieId: Int, completion: @escaping (Result<MovieListResponse, Error>) -> Void)
}

class FetchSimilarMoviesUseCaseImp: FetchSimilarMoviesUseCase {
    private let service: FetchSimilarMoviesServiceProtocol

    init(service: FetchSimilarMoviesServiceProtocol) {
        self.service = service
    }
    
    func execute(movieId: Int, completion: @escaping (Result<MovieListResponse, Error>) -> Void) {
        service.fetchSimilarMovies(movieId: movieId, completion: completion)
    }
}
