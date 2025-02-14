//
//  FetchMoviesService.swift
//  movie-app
//
//  Created by Robusta on 12/02/2025.
//

import Foundation

class FetchMoviesService: FetchMoviesServiceProtocol {
    func fetchMovies(completion: @escaping (Result<MovieListResponse, Error>) -> Void) {
        NetworkService.shared.fetchData(from: "https://api.themoviedb.org/3/movie/popular", completion: completion)
    }
}
