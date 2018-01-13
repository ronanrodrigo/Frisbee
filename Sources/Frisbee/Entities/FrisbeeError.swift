public enum FrisbeeError: Error {
    case invalidUrl
    case other(localizedDescription: String)
    case noData
    case invalidQuery
    case invalidEntity

    init(_ error: Error) {
        guard let frisbeeError = error as? FrisbeeError else {
            self = .other(localizedDescription: error.localizedDescription); return
        }
        self = frisbeeError
    }
}

extension FrisbeeError: Equatable {
    public static func == (lhs: FrisbeeError, rhs: FrisbeeError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidUrl, .invalidUrl),
             (.noData, .noData),
             (.invalidQuery, .invalidQuery),
             (.invalidEntity, .invalidEntity):
            return true
        case let (.other(lhs), .other(rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
}
