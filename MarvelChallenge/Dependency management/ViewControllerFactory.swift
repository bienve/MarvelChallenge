//
//  ViewControllerFactory.swift
//  MarvelChallenge
//
//  Created by 67881458 on 12/11/22.
//

import Foundation

protocol ViewControllerFactory {
    func provideCharacterCollectionViewController(coder: NSCoder) -> CharacterCollectionViewController?
    func provideCharacterDetailViewController(coder: NSCoder, character: Character, copyright: String) -> CharacterDetailViewController?
}
