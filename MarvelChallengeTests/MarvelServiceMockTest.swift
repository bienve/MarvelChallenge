//
//  MarvelServiceMockTest.swift
//  MarvelChallengeTests
//
//  Created by 67881458 on 14/11/22.
//

import XCTest
@testable import MarvelChallenge

final class MarvelServiceMockTest: XCTestCase {

    var characterMockService: CharactersServiceMock?
    
    override func setUpWithError() throws {
        characterMockService = CharactersServiceMock()
    }
    
    override func tearDownWithError() throws {
        characterMockService = nil
    }
    
    func testMockService() async throws {
        
        let response = try await characterMockService?.fetchCharactersList(offset: 2, limit: 1)
        let characters = try XCTUnwrap(response?.data?.results)
        let firstCharacterName = try XCTUnwrap(characters.first?.name)
        
        XCTAssertEqual(characters.count, 1)
        XCTAssertEqual(firstCharacterName, "A.I.M.")
        
    }
    
    func testMockServiceCase2() async throws {
        
        let response = try await characterMockService?.fetchCharactersList(offset: 29, limit: 99)
        
        let characters = try XCTUnwrap(response?.data?.results)
        let firstCharacterName = try XCTUnwrap(characters.first?.name)
        
        XCTAssertEqual(characters.count, 1)
        XCTAssertEqual(firstCharacterName, "Alexander Pierce")
        
    }
   
    
    func testMockServiceCase3() async throws {
        let response = try await characterMockService?.fetchCharactersList(offset: 200, limit: 99)
        let characters = try XCTUnwrap(response?.data?.results)
        
        XCTAssertEqual(characters.count, 0)
        
    }
    
    func testMockServiceCase4() async throws {
        
        do {
            let _ = try await characterMockService?.fetchCharactersList(offset: 1, limit: 200)
        } catch ApiError.serverError(let code) {
            XCTAssertEqual(code, 409)
        }
        
    }
    
    func testMockServiceCase5() async throws {
        let response = try await characterMockService?.fetchCharactersList(offset: 0, limit: 10)
        let characters = try XCTUnwrap(response?.data?.results)
        
        XCTAssertEqual(characters.count, 10)
    }

}
