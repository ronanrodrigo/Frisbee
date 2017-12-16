import Foundation

protocol FBEResultGeneratable {
    static func generate(data: Data?, error: Error?) -> FBEResult
}

struct FBEResultGenerator: FBEResultGeneratable {
    static func generate(data: Data?, error: Error?) -> FBEResult {
        if let data = data {
            return FBEResult.success(data)
        } else if let error = error {
            let otherError = FBEError.other(localizedDescription: error.localizedDescription)
            return FBEResult.fail(otherError)
        }
        let noDataError = FBEError.noData
        return FBEResult.fail(noDataError)
    }
}
