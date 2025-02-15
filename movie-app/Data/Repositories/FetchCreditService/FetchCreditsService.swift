//
//  FetchCreditsService.swift
//  movie-app
//
//  Created by Robusta on 15/02/2025.
//

import Foundation

class FetchCreditsService: FetchCreditServiceProtocol {
    func fetchCredits(movieId: Int, completion: @escaping (Result<CreditsResponse, Error>) -> Void) {
        NetworkService.shared.fetchData(from: "https://api.themoviedb.org/3/movie/\(movieId)/credits",
                                        completion: completion)
    }
    
    func fetchMultipleCredits(movieIds: [Int], completion: @escaping (Result<[Int: CreditsResponse], Error>) -> Void) {
            var results: [Int: CreditsResponse] = [:]
            let dispatchGroup = DispatchGroup()
            var encounteredError: Error?

            for movieId in movieIds {
                dispatchGroup.enter()
                fetchCredits(movieId: movieId) { result in
                    switch result {
                    case .success(let response):
                        results[movieId] = response
                    case .failure(let error):
                        encounteredError = error
                    }
                    dispatchGroup.leave()
                }
            }

            dispatchGroup.notify(queue: .main) {
                if let error = encounteredError {
                    completion(.failure(error))
                } else {
                    completion(.success(results))
                }
            }
        }
}
