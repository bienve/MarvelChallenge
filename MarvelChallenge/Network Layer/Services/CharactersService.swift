//
//  CharactersService.swift
//  MarvelChallenge
//
//  Created by 67881458 on 10/11/22.
//

import Foundation

struct PrintQueueService {
    
    var serviceManager: ServiceManager
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }
    
    func fetchCharactersList(page: Int, pageSize: Int) async throws -> MarvelResponse<CharacterDataContainer> {
        let request = try CharactersRequest.fetchCharacterList.asUrlRequest()
        return try await serviceManager.sendRequest(urlRequest: request)
    }
    
}
