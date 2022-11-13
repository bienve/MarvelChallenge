//
//  CharactersService.swift
//  MarvelChallenge
//
//  Created by 67881458 on 10/11/22.
//

import Foundation

protocol CharacterServiceProtocol {
    func fetchCharactersList(offset: Int, limit: Int) async throws -> MarvelResponse<CharacterDataContainer>
}

struct CharactersService: CharacterServiceProtocol {
    
    var serviceManager: ServiceManager
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }
    
    func fetchCharactersList(offset: Int, limit: Int) async throws -> MarvelResponse<CharacterDataContainer> {
        let request = try CharactersRequest.fetchCharacterList(offset, limit).asUrlRequest()
        return try await serviceManager.sendRequest(urlRequest: request)
    }
    
    /* 
    func fetchCharacterDetail(id: Int) async throws -> MarvelResponse<CharacterDataContainer> {
        let request = try CharactersRequest.fetchCharacterDetail(characterId: id).asUrlRequest()
        return try await serviceManager.sendRequest(urlRequest: request)
    }
    */
}
