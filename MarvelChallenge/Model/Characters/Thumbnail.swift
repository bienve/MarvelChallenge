// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let thumbnail = try? newJSONDecoder().decode(Thumbnail.self, from: jsonData)

import Foundation

// MARK: - Thumbnail
struct Thumbnail: Codable {
    
    let path, thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
    
}
