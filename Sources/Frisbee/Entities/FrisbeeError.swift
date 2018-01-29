import Foundation

public enum FrisbeeError: Error {
    case invalidUrl
    case other(localizedDescription: String)
    case noData
    case invalidQuery
    case invalidEntity
    case requestCancelled

    init(_ error: Error) {
        if let frisbeeError = error as? FrisbeeError {
            self = frisbeeError
            return
        }

        switch error {
        case URLError.cancelled:
            self = .requestCancelled
        default:
            self = .other(localizedDescription: error.localizedDescription)
        }

    }
}

extension FrisbeeError: Equatable {
    public static func == (lhs: FrisbeeError, rhs: FrisbeeError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidUrl, .invalidUrl),
             (.noData, .noData),
             (.invalidQuery, .invalidQuery),
             (.invalidEntity, .invalidEntity),
             (.requestCancelled, .requestCancelled):
            return true
        case let (.other(lhs), .other(rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
}
