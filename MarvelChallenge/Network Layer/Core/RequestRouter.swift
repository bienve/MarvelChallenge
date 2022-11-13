//
//  RequestProtocol.swift
//  MarvelChallenge
//
//  Created by 67881458 on 9/11/22.
//

import Foundation

enum HttpMethod: String {
    case GET, POST
}

protocol RequestRouter {
    
    var baseUrl: String {get}
    var pathComponent: String {get}
    var httpMethod: HttpMethod {get}
    var bodyParams: [String: Any]? {get}
    var urlParams: [String: String]? {get}
    
}

extension RequestRouter {
    
    //Default values
    var baseUrl: String { Environment.baseURL }
    var httpMethod: HttpMethod { .GET }
    
    var bodyParams: [String : Any]? { nil }
    var urlParams: [String : String]? { nil }
    
    func asUrlRequest() throws -> URLRequest {
        
        guard let url = URL(string: baseUrl)?
                .appendingPathComponent(self.pathComponent) else {
            fatalError("Bad url request")
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = self.httpMethod.rawValue

        if let bodyParams = bodyParams {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParams)
        }
        
        if let urlParams = urlParams {
            urlRequest.url?.append(queryItems: urlParams.map{ (key, value) in
                URLQueryItem(name: key, value: value)
            })
        }
        
        return urlRequest
        
    }
    
}
