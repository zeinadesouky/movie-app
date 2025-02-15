//
//  FetchSimilarMoviesService.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import Foundation

class FetchSimilarMoviesService: FetchSimilarMoviesServiceProtocol {
    func fetchSimilarMovies(movieId: Int, completion: @escaping (Result<MovieListResponse, Error>) -> Void) {
        NetworkService.shared.fetchData(from: "https://api.themoviedb.org/3/movie/\(movieId)/similar",
                                        completion: completion)
    }
}
