//
//  CharacterServiceMock.swift
//  MarvelChallenge
//
//  Created by 67881458 on 13/11/22.
//

import Foundation

struct CharactersServiceMock: CharacterServiceProtocol {
    
    func fetchCharactersList(offset: Int, limit: Int) async throws -> MarvelResponse<CharacterDataContainer> {
    
        guard limit > 0 && limit <= 100 else {
            throw ApiError.serverError(409)
        }
        
        if let path = Bundle.main.path(forResource: "MockResponse", ofType: "json") {
            
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let response = try JSONDecoder().decode(MarvelResponse<CharacterDataContainer>.self, from: data)
            let results = response.data?.results
    
            var characters : [Character] = []
            
            if offset < results?.count ?? 0 {
                
                var efectiveLimit: Int = offset
                
                if offset + limit < results?.count ?? 0 {
                    efectiveLimit += limit
                } else {
                    efectiveLimit += 1
                }
                
                print("efectiveLimit: \(efectiveLimit)")
                print("results count \(results?.count ?? -1)")
                
                characters = Array(results?[offset..<efectiveLimit] ?? [])
                
            }
            
            let characterDataContainer = CharacterDataContainer(offset: offset, limit: limit, total: response.data?.total, count: characters.count, results: characters)
            
            
            return MarvelResponse(code: response.code,
                                  status: response.status,
                                  copyright: response.copyright,
                                  attributionText: response.attributionText,
                                  attributionHTML: response.attributionHTML,
                                  etag: response.etag,
                                  data: characterDataContainer)
            
        } else {
            throw ApiError.badResponse
        }
        
    }
    
}
