//
//  CreditsResponse.swift
//  movie-app
//
//  Created by Robusta on 15/02/2025.
//

import Foundation

struct CreditsResponse: Decodable {
    let id: Int?
    let cast: [PersonnelInfo]?
    let crew: [PersonnelInfo]?
}

struct PersonnelInfo: Decodable {
    let id: Int?
    let popularity: Float?
    let originalName: String?
    let profilePath: String?
    let knownForDepartment: String?
    
    enum CodingKeys: String, CodingKey {
        case id, popularity
        case originalName = "original_name"
        case profilePath = "profile_path"
        case knownForDepartment = "known_for_department"
    }
}
