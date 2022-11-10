// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let comicsItem = try? newJSONDecoder().decode(ComicsItem.self, from: jsonData)

import Foundation

// MARK: - ComicsItem
struct ResourceItem: Codable {
    let resourceURI, name: String?
}
