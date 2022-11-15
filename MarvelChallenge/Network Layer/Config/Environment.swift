//
//  Environment.swift
//  MarvelChallenge
//
//  Created by 67881458 on 9/11/22.
//

import Foundation

/*
 * Retrieves environment params from current configuration
 */
public enum Environment {
    
    // MARK: - Keys
    private enum Keys : String {
        case baseURL = "BASE_URL"
        case publicApiKey = "MARVEL_PUBLIC_API_KEY"
        case privateApiKey = "MARVEL_PRIVATE_API_KEY"
    }

    // MARK: - Plist file
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Info.plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
    static let baseURL: String = {
        guard let baseURLString = Environment.infoDictionary[Keys.baseURL.rawValue] as? String else {
            fatalError("\(Keys.baseURL) not set in plist for this environment")
        }
        
        return baseURLString
    }()
    
    static let marvelPublicApiKey: String = {
        guard let apiKey = Environment.infoDictionary[Keys.publicApiKey.rawValue] as? String else {
            fatalError("\(Keys.publicApiKey) not set in plist for this environment")
        }
        
        return apiKey
    }()
    
    static let marvelPrivateApiKey: String = {
        guard let apiKey = Environment.infoDictionary[Keys.privateApiKey.rawValue] as? String else {
            fatalError("\(Keys.privateApiKey) not set in plist for this environment")
        }
        
        return apiKey
    }()
    
}
