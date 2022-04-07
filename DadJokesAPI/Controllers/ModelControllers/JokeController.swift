//
//  JokeController.swift
//  DadJokesAPI
//
//  Created by Keith Mair on 4/6/22.
//

import Foundation

class JokeController {
    
    static let baseURL = URL(string: "https://icanhazdadjoke.com")
    
    static func fetchDadJoke(completion: @escaping (Result<String, errorHandler>) -> Void) {
        
        guard let baseURL = baseURL
        else { return completion(.failure(.invalidURL))}
        
        var request = URLRequest(url: baseURL)
        request.allHTTPHeaderFields = ["Accept": "application/json"]
        print(request)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("POST STATUS CODE: \(response.statusCode)")
                }
            }
            
            guard let data = data
            else {return completion(.failure(.noData))}
            print(data.first!)
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let joke = topLevelObject.joke
                completion(.success(joke))
                
            } catch {
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}

