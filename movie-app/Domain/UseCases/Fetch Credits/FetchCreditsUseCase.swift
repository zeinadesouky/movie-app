//
//  FetchCreditsUseCase.swift
//  movie-app
//
//  Created by Robusta on 15/02/2025.
//

import Foundation

protocol FetchCreditsUseCase {
    func execute(movieId: Int, completion: @escaping (Result<CreditsResponse, Error>) -> Void)
    func executeMultiple(movieIds: [Int], completion: @escaping (Result<[Int: CreditsResponse], Error>) -> Void)
}

class FetchCreditsUseCaseImp: FetchCreditsUseCase {
    private let service: FetchCreditServiceProtocol

    init(service: FetchCreditServiceProtocol) {
        self.service = service
    }
    
    func execute(movieId: Int, completion: @escaping (Result<CreditsResponse, Error>) -> Void) {
        service.fetchCredits(movieId: movieId, completion: completion)
    }
    
    func executeMultiple(movieIds: [Int], completion: @escaping (Result<[Int: CreditsResponse], Error>) -> Void) {
        service.fetchMultipleCredits(movieIds: movieIds, completion: completion)
    }
}
