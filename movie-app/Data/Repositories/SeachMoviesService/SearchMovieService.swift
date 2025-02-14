//
//  SearchMovieService.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import Foundation

class SearchMovieService: SearchMoviesServiceProtocol {
    func searchMovies(searchKeyword: String, completion: @escaping (Result<MovieListResponse, Error>) -> Void) {
        NetworkService.shared.fetchData(from: "https://api.themoviedb.org/3/search/movie",
                                        queryParams: ["query": searchKeyword],
                                        completion: completion)
    }
}
