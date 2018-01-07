public enum FrisbeeError: Error {
    case invalidUrl
    case other(localizedDescription: String)
    case noData
    case invalidQuery
    case invalidEntity
    case unknown
}

extension FrisbeeError: Equatable {
    public static func == (lhs: FrisbeeError, rhs: FrisbeeError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidUrl, .invalidUrl),
             (.noData, .noData),
             (.invalidQuery, .invalidQuery),
             (.invalidEntity, .invalidEntity),
             (.unknown, .unknown):
            return true
        case let (.other(lhs), .other(rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
}
