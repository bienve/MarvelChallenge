// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let result = try? newJSONDecoder().decode(Result.self, from: jsonData)

import Foundation

// MARK: - Result
struct Character: Codable {
    let id: Int?
    let name, description, modified, resourceURI: String?
    let urls: [URLElement]?
    let thumbnail: Thumbnail?
    let comics, stories, events, series: ResourceList?
    
    func getThumbnailUrl(preferredVariant: String) -> URL? {
        
        guard let thumbnail = thumbnail,
              let thumbPath = thumbnail.path,
              let thumbExtension = thumbnail.thumbnailExtension else {
            
            return nil
            
        }
        
        return URL(string: thumbPath)?
            .appendingPathComponent(preferredVariant)
            .appendingPathExtension(thumbExtension)
    }
}
