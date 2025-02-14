//
//  SearchMoviesUseCase.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import Foundation

protocol SearchMoviesUseCase {
    func execute(searchKeyword: String, completion: @escaping (Result<MovieListResponse, Error>) -> Void)
}

class SearchMoviesUseCaseImp: SearchMoviesUseCase {
    private let service: SearchMoviesServiceProtocol

    init(service: SearchMoviesServiceProtocol) {
        self.service = service
    }
    
    func execute(searchKeyword: String, completion: @escaping (Result<MovieListResponse, Error>) -> Void) {
        service.searchMovies(searchKeyword: searchKeyword, completion: completion)
    }
}
