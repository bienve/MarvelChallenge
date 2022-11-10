// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let result = try? newJSONDecoder().decode(Result.self, from: jsonData)

import Foundation

// MARK: - Result
struct Character: Codable {
    let id, name, description, modified, resourceURI: String?
    let urls: [URLElement]?
    let thumbnail: Thumbnail?
    let comics: ComicList?
    let stories: Stories?
    let events, series: ComicList?
}
