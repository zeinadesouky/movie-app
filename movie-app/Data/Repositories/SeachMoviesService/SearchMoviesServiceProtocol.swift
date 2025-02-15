//
//  SearchMoviesServiceProtocol.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import Foundation

protocol SearchMoviesServiceProtocol {
    func searchMovies(searchKeyword: String, completion: @escaping (Result<MovieListResponse, Error>) -> Void)
}
