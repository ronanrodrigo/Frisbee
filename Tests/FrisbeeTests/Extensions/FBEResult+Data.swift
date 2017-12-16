import Foundation
import Frisbee

extension FBEResult {
    var data: Data? {
        switch self {
        case let .success(data): return data
        default: return nil
        }
    }
}
