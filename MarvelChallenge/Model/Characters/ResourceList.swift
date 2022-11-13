// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let comics = try? newJSONDecoder().decode(Comics.self, from: jsonData)

import Foundation

// MARK: - Comics
struct ResourceList: Codable {
    let available, returned: Int?
    let collectionURI: String?
    let items: [ResourceItem]?
}
