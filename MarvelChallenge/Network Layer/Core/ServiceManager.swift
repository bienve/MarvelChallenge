//
//  ServiceManager.swift
//  MarvelChallenge
//
//  Created by 67881458 on 10/11/22.
//

import Foundation

class ServiceManager {
    
    private let decoder = JSONDecoder()
    private let urlSession: URLSession
    private var authenticator: ServiceAuthenticator?
    
    init(urlSession: URLSession = URLSession.shared, authenticator: ServiceAuthenticator? = nil) {
        self.urlSession = urlSession
        self.authenticator = authenticator
    }
    
    public func sendRequest<T: Decodable>(urlRequest: URLRequest) async throws -> T {
        
        var request: URLRequest
        
        if let authenticator = self.authenticator {
            request = authenticator.authenticateRequest(urlRequest: urlRequest)
        } else {
            request = urlRequest
        }
        
        print("\(request.url?.description ?? "")")
        
        let (data, response) = try await self.urlSession.data(for: request)
        
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
