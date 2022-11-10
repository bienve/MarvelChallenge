// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let dataClass = try? newJSONDecoder().decode(DataClass.self, from: jsonData)

import Foundation

// MARK: - DataClass
struct CharacterDataContainer: Codable {
    let offset, limit, total, count: String?
    let results: [Character]?
}
