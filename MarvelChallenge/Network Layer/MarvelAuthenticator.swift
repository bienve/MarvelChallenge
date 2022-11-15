//
//  MarvelAuthenticator.swift
//  MarvelChallenge
//
//  Created by 67881458 on 10/11/22.
//

import Foundation
import CryptoKit

/*
 * Provides authentication for the marvel api
 */
class MarvelAuthenticator: ServiceAuthenticator {
    
    private let publicKey: String
    private let timeStamp: String
    private let hash: String
    
    init(publicKey: String, privateKey: String) {
        
        self.publicKey = publicKey
        self.timeStamp = "\(Date.now.timeIntervalSince1970)"
        
        let hash = "\(timeStamp)\(privateKey)\(publicKey)"
        let digest = Insecure.MD5.hash(data: hash.data(using: .utf8) ?? Data())
        
        self.hash = digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    
    func authenticateRequest(urlRequest: URLRequest) -> URLRequest {
        
        var urlRequest = urlRequest
        
        let authQueryItems = [
            URLQueryItem(name: "ts", value: timeStamp),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "apikey", value: publicKey)
        ]
        
        urlRequest.url?.append(queryItems: authQueryItems)
        
        return urlRequest
    }
    
}
