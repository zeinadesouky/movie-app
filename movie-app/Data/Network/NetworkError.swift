//
//  NetworkError.swift
//  movie-app
//
//  Created by Robusta on 12/02/2025.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case networkFailure(Error)
    case invalidResponse
    case noData
    case decodingFailure(Error)
    
    var errorDescription: String? {
        switch self {
        case .networkFailure(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid server response."
        case .noData:
            return "No data received from server."
        case .decodingFailure(let error):
            return "Failed to decode data: \(error.localizedDescription)"
        }
    }
}
