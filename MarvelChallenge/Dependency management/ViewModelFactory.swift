//
//  ViewModelFactory.swift
//  MarvelChallenge
//
//  Created by 67881458 on 12/11/22.
//

import Foundation

protocol ViewModelFactory {
    func provideCharacterCollectionViewModel() -> CharacterCollectionViewModel
    func provideCharacterDetailViewModel(character: Character, copyright: String) -> CharacterDetailViewModel
}
