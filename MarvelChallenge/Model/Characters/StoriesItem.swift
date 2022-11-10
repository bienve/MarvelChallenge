// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let storiesItem = try? newJSONDecoder().decode(StoriesItem.self, from: jsonData)

import Foundation

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI, name, type: String?
}
