import Foundation
import Frisbee

extension FrisbeeError {
    static func all(error: Error) -> [FrisbeeError] {
        return [FrisbeeError.invalidUrl, .invalidQuery,
                .invalidEntity, .noData, .unknown,
                .other(localizedDescription: error.localizedDescription)]
    }
}
