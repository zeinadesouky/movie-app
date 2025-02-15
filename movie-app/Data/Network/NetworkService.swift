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
    
    private let apiKey = "723d8670be167e4d9b1c8818cb2fabeb"

    
    private func buildURL(baseURL: String, queryParams: [String: String]) -> URL? {
        var components = URLComponents(string: baseURL)
        var allQueryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        allQueryItems.append(URLQueryItem(name: "api_key",
                                          value: apiKey))
        components?.queryItems = allQueryItems
        return components?.url
    }
        
        private func createRequest(url: URL) -> URLRequest {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = [
                "accept": "application/json"
            ]
            return request
        }

        func fetchData<T: Decodable>(from baseURL: String, queryParams: [String: String] = [:], completion: @escaping (Result<T, Error>) -> Void) {
            guard let url = buildURL(baseURL: baseURL, queryParams: queryParams) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            let request = createRequest(url: url)

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
                
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON Response: \(jsonString)")
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
