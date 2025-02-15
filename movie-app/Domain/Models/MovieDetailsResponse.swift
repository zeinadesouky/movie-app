//
//  MovieDetailsResponse.swift
//  movie-app
//
//  Created by Robusta on 14/02/2025.
//

import Foundation

struct MovieDetails: Decodable {
    let id: Int?
    let title: String?
    let revenue: Int?
    let status: String?
    let tagline: String?
    let releaseDate: String?
    let overview: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, revenue, status, tagline
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}
