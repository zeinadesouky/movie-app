//
//  FetchCreditServiceProtocol.swift
//  movie-app
//
//  Created by Robusta on 15/02/2025.
//

import Foundation

protocol FetchCreditServiceProtocol {
    func fetchCredits(movieId: Int, completion: @escaping (Result<CreditsResponse, Error>) -> Void)
    func fetchMultipleCredits(movieIds: [Int], completion: @escaping (Result<[Int: CreditsResponse], Error>) -> Void)
}
