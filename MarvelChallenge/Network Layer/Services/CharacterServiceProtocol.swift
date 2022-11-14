//
//  CharacterServiceProtocol.swift
//  MarvelChallenge
//
//  Created by 67881458 on 13/11/22.
//

import Foundation

protocol CharacterServiceProtocol {
    func fetchCharactersList(offset: Int, limit: Int) async throws -> MarvelResponse<CharacterDataContainer>
}
