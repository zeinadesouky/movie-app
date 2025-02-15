//
//  MovieEntity.swift
//  movie-app
//
//  Created by Robusta on 13/02/2025.
//

import Foundation

struct MovieEntity {
    var id: Int?
    var title: String?
    var releaseDate: String?
    var overview: String?
    var posterPath: String?
    var isInWatchlist: Bool?
    var formattedReleaseDate: Date?
}
