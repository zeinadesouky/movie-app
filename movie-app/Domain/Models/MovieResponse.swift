//
//  MovieResponse.swift
//  movie-app
//
//  Created by Robusta on 12/02/2025.
//

import Foundation

struct MovieListResponse: Decodable {
    let page: Int?
    let totalPages: Int?
    let totalResults: Int?
    let results: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movie: Decodable {
    let id: Int?
    let title: String?
    let releaseDate: String?
    let overview: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
    
    func toMovieEntity() -> MovieEntity {
        var movieEntity = MovieEntity()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        movieEntity.id = id
        movieEntity.title = title
        movieEntity.releaseDate = releaseDate
        movieEntity.overview = overview
        movieEntity.posterPath = posterPath
        movieEntity.isInWatchlist = UserUtilities.loadWatchlist().contains(where: {$0 == id})
        movieEntity.formattedReleaseDate = formatter.date(from: releaseDate ?? "")
        return movieEntity
    }
}
