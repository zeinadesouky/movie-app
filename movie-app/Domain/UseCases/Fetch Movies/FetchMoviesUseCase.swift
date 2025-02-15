//
//  FetchMoviesUseCase.swift
//  movie-app
//
//  Created by Robusta on 12/02/2025.
//

import Foundation

protocol FetchMoviesUseCase {
    func execute(page: Int, completion: @escaping (Result<MovieListResponse, Error>) -> Void)
}

class FetchMoviesUseCaseImp: FetchMoviesUseCase {
    private let movieService: FetchMoviesServiceProtocol
    
    init(movieService: FetchMoviesServiceProtocol) {
        self.movieService = movieService
    }
    
    func execute(page: Int, completion: @escaping (Result<MovieListResponse, Error>) -> Void) {
        movieService.fetchMovies(page: page, completion: completion)
    }
}
