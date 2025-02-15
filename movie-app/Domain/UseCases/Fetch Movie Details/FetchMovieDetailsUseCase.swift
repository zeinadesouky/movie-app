//
//  FetchMovieDetailsUseCase.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import Foundation

protocol FetchMovieDetailsUseCase {
    func execute(movieId: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void)
}

class FetchMovieDetailsUseCaseImp: FetchMovieDetailsUseCase {
    private let service: FetchMovieDetailsServiceProtocol

    init(service: FetchMovieDetailsServiceProtocol) {
        self.service = service
    }
    
    func execute(movieId: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
        service.fetchMovieDetails(movieId: movieId, completion: completion)
    }
}
