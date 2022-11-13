//
//  CharactersRequest.swift
//  MarvelChallenge
//
//  Created by 67881458 on 10/11/22.
//

import Foundation

enum CharactersRequest: RequestRouter {
    
    private enum ParamKey: String {
        case offset, limit
    }
    
    case fetchCharacterList(_ offset: Int, _ limit: Int)
    //case fetchCharacterDetail(characterId: Int)
    
    var pathComponent: String {
        switch self {
        case .fetchCharacterList:
            return Endpoint.characterList
        /*
        case .fetchCharacterDetail(let characterId):
            return String(format: Endpoint.characterDetail, characterId)
         */
        }
         
    }
    
    var urlParams: [String: String]? {
        switch self {
        case .fetchCharacterList(let offset, let limit):
            return [ParamKey.offset.rawValue : "\(offset)",
                    ParamKey.limit.rawValue : "\(limit)"
            ]
        }
    }
    
    
}
