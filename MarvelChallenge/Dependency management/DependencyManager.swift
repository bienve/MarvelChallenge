//
//  DependencyManager.swift
//  MarvelChallenge
//
//  Created by 67881458 on 12/11/22.
//

import Foundation

class DependencyManager {
    
    private lazy var marvelAuthenticator = MarvelAuthenticator(publicKey: Environment.marvelPublicApiKey,
                                                               privateKey: Environment.marvelPrivateApiKey)
    
    private lazy var serviceManager = ServiceManager(authenticator: marvelAuthenticator)
    private lazy var characterService = CharactersService(serviceManager: serviceManager)
    
    private static var sharedInstance: DependencyManager = {
        return DependencyManager()
    }()
    
    class func shared() -> DependencyManager {return sharedInstance}
    
    private init() {}
    
}

extension DependencyManager: ViewModelFactory {
    
    func provideCharacterCollectionViewModel() -> CharacterCollectionViewModel {
        return CharacterCollectionViewModel(charactersService: characterService)
    }
    
    func provideCharacterDetailViewModel(character: Character, copyright: String) -> CharacterDetailViewModel {
        return CharacterDetailViewModel(character: character, copyright: copyright)
    }
    
}

extension DependencyManager: ViewControllerFactory {
    
    func provideCharacterCollectionViewController(coder: NSCoder) -> CharacterCollectionViewController? {
        let viewModel = provideCharacterCollectionViewModel()
        let viewController = CharacterCollectionViewController(coder: coder, viewModel: viewModel)
        
        return viewController
    }
    
    func provideCharacterDetailViewController(coder: NSCoder, character: Character, copyright: String) -> CharacterDetailViewController? {
        let viewModel = provideCharacterDetailViewModel(character: character, copyright: copyright)
        let viewController = CharacterDetailViewController(coder: coder, viewModel: viewModel)
        
        return viewController
    }
    
    
}
