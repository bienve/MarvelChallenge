//
//  ServiceAuthenticator.swift
//  MarvelChallenge
//
//  Created by 67881458 on 11/11/22.
//

import Foundation

protocol ServiceAuthenticator {
    func authenticateRequest(urlRequest: URLRequest) -> URLRequest
}
