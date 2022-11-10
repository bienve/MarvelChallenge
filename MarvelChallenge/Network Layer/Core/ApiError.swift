//
//  ApiError.swift
//  MarvelChallenge
//
//  Created by 67881458 on 10/11/22.
//

import Foundation

enum ApiError: Error {
    case serverError(Int)
    case badResponse
}
