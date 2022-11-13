//
//  CharacterCollectionViewModel.swift
//  MarvelChallenge
//
//  Created by 67881458 on 12/11/22.
//

import Foundation
import Combine

class CharacterCollectionViewModel {
    
    private let charactersService: CharacterServiceProtocol
    
    @Published var isLoading: Bool = false
    @Published var characterCount: Int = 0
    var copyrigyt: String?
    
    var errorSubject = PassthroughSubject<String, Never>()
    
    private let pageSize = 30
    private var currentPage: Int = 0
    private var pagingReachedEnd: Bool = false
    private var characterList: [Character] = []
    
    init(charactersService: CharacterServiceProtocol) {
        self.charactersService = charactersService
        self.fetchCharacterList()
    }
    
    private func fetchCharacterList() {
        
        isLoading = true
        
        Task {
            
            do {
                
                print("Downloading character page: \(currentPage)")
                
                let characterRequestResult = try await charactersService.fetchCharactersList(offset: currentPage * pageSize, limit: pageSize)
                
                guard let characters = characterRequestResult.data?.results else {
                    //TODO: HANDLE ERROR
                    return
                }
                
                self.copyrigyt = characterRequestResult.attributionText
                
                addPage(characters)
                
            } catch {
                print(error)
                errorSubject.send("Error fetching character list.")
            }
         
            isLoading = false
        }
        
    }
    
    private func addPage(_ characters: [Character]) {
        self.characterList.append(contentsOf: characters)
        self.currentPage += 1
        self.characterCount = self.characterList.count
        self.pagingReachedEnd = characters.count < pageSize
    }
    
    func getCharacter(index: Int) -> Character? {
        
        guard index >= 0 && index < characterList.count else {
            return nil
        }
        
        if (!pagingReachedEnd && index == characterCount - pageSize / 2) {
            self.fetchCharacterList()
        }
        
        return self.characterList[index]
    }
    
}
