import Foundation
import Frisbee

extension FrisbeeError {
    static func all(error: Error) -> [FrisbeeError] {
        return [FrisbeeError.invalidUrl, .invalidQuery, .invalidEntity, .noData, .requestCancelled,
                .other(localizedDescription: error.localizedDescription)]
    }
}
