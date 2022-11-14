//
//  CharacterCollectionViewModelTest.swift
//  MarvelChallengeTests
//
//  Created by 67881458 on 13/11/22.
//

import XCTest
import Combine
@testable import MarvelChallenge

final class CharacterCollectionViewModelTest: XCTestCase {
    
    lazy var characterMockService = CharactersServiceMock()
    var viewModel : CharacterCollectionViewModel!
    
    private let pageSize = 10
    
    private var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        viewModel = CharacterCollectionViewModel(charactersService: characterMockService, pageSize: pageSize)
    }
    
    override func tearDownWithError() throws {
        cancellables.removeAll()
        viewModel = nil
    }
    
    /*
     * Test the initial fetch
     */
    func testViewModelCase1() throws {
        
        let expectation = XCTestExpectation(description: "FetchFirstPage")
        
        viewModel.$characterCount.dropFirst().sink {[weak self] value in
            XCTAssertEqual(value, self?.pageSize)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
        
        let character = try XCTUnwrap(viewModel.getCharacter(index: 2))
        let characterName = try XCTUnwrap(character.name)
        
        XCTAssertEqual(characterName, "A.I.M.")
        
    }
    
    /*
     * Test one page change
     */
    func testViewModelCase2() throws {
        
        let initialFetchExpectation = XCTestExpectation(description: "FirstFetchPage")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            XCTAssertEqual(self.viewModel.characterCount, self.pageSize)
            initialFetchExpectation.fulfill()
        }
        
        wait(for: [initialFetchExpectation], timeout: 5)
    
        let character = try XCTUnwrap(viewModel.getCharacter(index: 5))
        
        let secondPageFetchExpectation = XCTestExpectation(description: "FetchSecondPage")
        
        viewModel.$characterCount.dropFirst(1).sink {[weak self] value in
            XCTAssertEqual(value, (self?.pageSize ?? 0) * 2)
            secondPageFetchExpectation.fulfill()
        }.store(in: &cancellables)

        //let character = try XCTUnwrap(viewModel.getCharacter(index: 7))
        //let characterName = try XCTUnwrap(character.name)
        
        wait(for: [secondPageFetchExpectation], timeout: 4)
        
        XCTAssertEqual(self.viewModel.characterCount, self.pageSize * 2)
        XCTAssertEqual(character.name, "Abomination (Ultimate)")
        
    }
    
    

}
