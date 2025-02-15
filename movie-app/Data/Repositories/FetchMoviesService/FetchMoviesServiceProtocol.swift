//
//  FetchMoviesServiceProtocol.swift
//  movie-app
//
//  Created by Robusta on 12/02/2025.
//

import Foundation

protocol FetchMoviesServiceProtocol {
    func fetchMovies(page: Int, completion: @escaping (Result<MovieListResponse, Error>) -> Void)
}
