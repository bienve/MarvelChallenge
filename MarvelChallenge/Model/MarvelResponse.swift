//
//  MarvelResponse.swift
//  MarvelChallenge
//
//  Created by 67881458 on 10/11/22.
//

import Foundation

// MARK: - Welcome
struct MarvelResponse<T: Codable> : Codable {
    
    let code, status, copyright, attributionText: String?
    let attributionHTML: String?
    let etag: String?
    let data: T?
}
