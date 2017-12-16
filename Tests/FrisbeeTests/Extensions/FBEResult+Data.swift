import Foundation
import Frisbee

extension FBEResult {
    var data: Data? {
        switch self {
        case let .success(data): return data
        default: return nil
        }
    }

    var error: FBEError? {
        switch self {
        case let .fail(error): return error
        default: return nil
        }
    }
}
