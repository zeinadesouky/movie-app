//
//  FetchSimilarMoviesServiceProtocol.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import Foundation

protocol FetchSimilarMoviesServiceProtocol {
    func fetchSimilarMovies(movieId: Int, completion: @escaping (Result<MovieListResponse, Error>) -> Void)
}
