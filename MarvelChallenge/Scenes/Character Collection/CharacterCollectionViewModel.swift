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
    
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var characterCount: Int = 0
    private(set) var copyrigyt: String?
    
    private static let defaultPageSize = 40
    private let pageSize: Int
    
    private var currentPage: Int = 0
    private var pagingReachedEnd: Bool = false
    private var characterList: [Character] = []
    
    //MARK: - ERROR HANDLE
    private(set) var errorSubject = PassthroughSubject<String, Never>()
    
    private enum ViewModelError {
        
        case unexpected, badResponse, httpError(code: Int)
        
        func formatedErrorString() -> String {
            let baseErrorMessage = "Error fetching character list: "
            var reason: String
            
            switch self {
            case .badResponse:
                reason = "Bad response"
            case .unexpected:
                reason = "Unexpected error"
            case .httpError(let code):
                reason = "Http error \(code)"
            }
            
            return baseErrorMessage + reason
        }
    }
    
    //MARK: - INITIALIZERS
    
    init(charactersService: CharacterServiceProtocol, pageSize: Int = defaultPageSize) {
        self.pageSize = pageSize
        self.charactersService = charactersService
        self.fetchCharacterList()
    }
    
    //MARK: - FUNCTIONS
    private func fetchCharacterList() {
        
        isLoading = true
        
        Task {
            
            do {
                
                print("Downloading character page: \(currentPage)")
                
                let characterRequestResult = try await charactersService.fetchCharactersList(offset: currentPage * pageSize, limit: pageSize)
                
                
                guard let characters = characterRequestResult.data?.results else {
                    errorSubject.send(ViewModelError.unexpected.formatedErrorString())
                    return
                }
                
                
                self.copyrigyt = characterRequestResult.attributionText
                
                addPage(characters)
                
            } catch ApiError.badResponse {
                errorSubject.send(ViewModelError.badResponse.formatedErrorString())
            } catch ApiError.serverError(let code) {
                errorSubject.send(ViewModelError.httpError(code: code).formatedErrorString())
            } catch {
                errorSubject.send(ViewModelError.unexpected.formatedErrorString())
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
        
        guard index >= 0 && index < self.characterCount else {
            return nil
        }
        
        if (!pagingReachedEnd && index == characterCount - pageSize / 2) {
            self.fetchCharacterList()
        }
        
        return self.characterList[index]
    }
    
}
