import Foundation
import Frisbee

extension Result {
    var data: Entity? {
        switch self {
        case let .success(data): return data
        default: return nil
        }
    }

    var error: FrisbeeError? {
        switch self {
        case let .fail(error): return error
        default: return nil
        }
    }
}
