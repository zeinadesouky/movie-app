//
//  FetchMovieDetailsServiceProtocol.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import Foundation

protocol FetchMovieDetailsServiceProtocol {
    func fetchMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void)
}
