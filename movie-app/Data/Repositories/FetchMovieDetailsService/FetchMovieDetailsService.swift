//
//  FetchMovieDetailsService.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import Foundation

class FetchMovieDetailsService: FetchMovieDetailsServiceProtocol {
    func fetchMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
        NetworkService.shared.fetchData(from: "https://api.themoviedb.org/3/movie/\(movieId)",
                                        completion: completion)
    }
}
