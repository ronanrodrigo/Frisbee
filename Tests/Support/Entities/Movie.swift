import Foundation

struct Movie: Encodable {
    let name: String
    let releaseYear: Int

    enum CodingKeys: String, CodingKey {
        case name, releaseYear = "release_year"
    }
}
