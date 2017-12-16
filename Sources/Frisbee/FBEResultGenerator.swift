import Foundation

protocol FBEResultGeneratable {
    static func generateResult(data: Data?, error: Error?) -> FBEResult
}

struct FBEResultGenerator: FBEResultGeneratable {
    static func generateResult(data: Data?, error: Error?) -> FBEResult {
        if let data = data {
            return .success(data)
        } else if let error = error {
            return .error(.other(error))
        }
        return .error(.noData)
    }
}
