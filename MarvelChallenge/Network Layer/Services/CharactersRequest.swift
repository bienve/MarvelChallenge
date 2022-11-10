//
//  CharactersRequest.swift
//  MarvelChallenge
//
//  Created by 67881458 on 10/11/22.
//

import Foundation

enum CharactersRequest: RequestRouter {
    
    case fetchCharacterList
    case fetchCharacterDetail(characterId: Int)
    
    var pathComponent: String {
        switch self {
        case .fetchCharacterList:
            return Endpoint.characterList
        case .fetchCharacterDetail(let characterId):
            return String(format: Endpoint.characterDetail, characterId)
        }
    }
    
    
}
