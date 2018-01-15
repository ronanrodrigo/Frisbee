import Foundation

struct Empty: Codable, Equatable {
    static let data: Data = "{}".data(using: .utf8)!

    static func == (lhs: Empty, rhs: Empty) -> Bool {
        return true
    }
}
