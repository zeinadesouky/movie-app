//
//  NetworkService.swift
//  movie-app
//
//  Created by Robusta on 12/02/2025.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    func fetchData<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.networkFailure(error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NetworkError.decodingFailure(error)))
            }
        }
        task.resume()
    }
}
