//
//  NetworkLayer.swift
//  MarvelChallengeTests
//
//  Created by 67881458 on 13/11/22.
//

import XCTest
@testable import MarvelChallenge

final class NetworkLayerTest: XCTestCase {
    
    let auth = MarvelAuthenticator(publicKey: Environment.marvelPublicApiKey,
                                   privateKey: Environment.marvelPublicApiKey)
    
    var request: URLRequest!
    
    override func setUpWithError() throws {
        request = try CharactersRequest.fetchCharacterList(1, 5).asUrlRequest()
    }
    
    override func tearDownWithError() throws {
        request = nil
    }
    
    func testCharaterRequest() throws {
        
        let url =  try XCTUnwrap(request.url)
        let host = try XCTUnwrap(url.host)
        let scheme = try XCTUnwrap(url.scheme)
        
        let environmentBaseURl = Environment.baseURL
        
        XCTAssertEqual(scheme, "https")
        XCTAssertTrue(environmentBaseURl.contains(host))
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertTrue(url.absoluteString.contains("offset=1"))
        XCTAssertTrue(url.absoluteString.contains("limit=5"))
        
    }
    
    func testMarvelAuthenticator() throws {
        
        let authenticatedRequest = auth.authenticateRequest(urlRequest: request)
        
        let url =  try XCTUnwrap(authenticatedRequest.url?.absoluteString)
        
        XCTAssertTrue(url.contains("ts="))
        XCTAssertTrue(url.contains("hash="))
        XCTAssertTrue(url.contains(Environment.marvelPublicApiKey))
        
    }
    

}
