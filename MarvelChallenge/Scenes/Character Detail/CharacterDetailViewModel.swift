//
//  CharacterDetailViewModel.swift
//  MarvelChallenge
//
//  Created by 67881458 on 12/11/22.
//

import Foundation

class CharacterDetailViewModel {
    
    private static let preferredImageVariant = "detail"
    
    private let character: Character
    
    @Published var imageURL: URL?
    @Published var characterName: String?
    @Published var characterDescription: String?
    @Published var copyright: String?
    @Published var comics: Int?
    @Published var stories: Int?
    @Published var events: Int?
    @Published var series: Int?
    
    
    init(character: Character, copyright: String) {
        self.character = character
        
        self.imageURL = character.getThumbnailUrl(preferredVariant: CharacterDetailViewModel.preferredImageVariant)
        self.characterName = character.name
        self.characterDescription = character.description
        
        self.comics = character.comics?.returned
        self.series = character.series?.returned
        self.events = character.events?.returned
        self.stories = character.events?.returned
        
        self.copyright = copyright
    }
    
}
