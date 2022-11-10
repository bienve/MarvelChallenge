//
//  ServiceManager.swift
//  MarvelChallenge
//
//  Created by 67881458 on 10/11/22.
//

import Foundation

class ServiceManager {
    
    private let maxRetries = 3
    private let decoder = JSONDecoder()
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    public func sendRequest<T: Decodable>(urlRequest: URLRequest) async throws -> T {
        
        let (data, response) = try await self.urlSession.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else {
            throw ApiError.badResponse
        }
        
        let httpResponseStatusCode = response.statusCode
        
        guard (200...299).contains(httpResponseStatusCode) else {
            throw ApiError.serverError(httpResponseStatusCode)
        }
        
        return try decoder.decode(T.self, from: data)
        
    }
    
}
