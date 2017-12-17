import Foundation

protocol FBEResultGeneratable {
    associatedtype Entity
    static func generate(data: Data?, error: Error?) -> FBEResult<Entity>
}

struct FBEResultGenerator<Entity: Decodable>: FBEResultGeneratable {
    static func generate(data: Data?, error: Error?) -> FBEResult<Entity> {
        if let data = data {
            do {
                let entityDecoded = try JSONDecoder().decode(Entity.self, from: data)
                return FBEResult.success(entityDecoded)
            } catch {
                let noDataError = FBEError.noData
                return FBEResult.fail(noDataError)
            }
        } else if let error = error {
            let otherError = FBEError.other(localizedDescription: error.localizedDescription)
            return FBEResult.fail(otherError)
        }
        let noDataError = FBEError.noData
        return FBEResult.fail(noDataError)
    }
}
