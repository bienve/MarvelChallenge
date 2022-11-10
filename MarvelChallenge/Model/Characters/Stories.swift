// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let stories = try? newJSONDecoder().decode(Stories.self, from: jsonData)

import Foundation

// MARK: - Stories
struct Stories: Codable {
    let available, returned, collectionURI: String?
    let items: [StoriesItem]?
}
