import Foundation

protocol ResultGeneratable {
    associatedtype Entity
    static func generate(data: Data?, error: Error?) -> Result<Entity>
}

struct ResultGenerator<Entity: Decodable>: ResultGeneratable {
    static func generate(data: Data?, error: Error?) -> Result<Entity> {
        if let data = data {
            do {
                let entityDecoded = try JSONDecoder().decode(Entity.self, from: data)
                return Result.success(entityDecoded)
            } catch {
                let noDataError = FrisbeeError.noData
                return Result.fail(noDataError)
            }
        } else if let error = error {
            let otherError = FrisbeeError.other(localizedDescription: error.localizedDescription)
            return Result.fail(otherError)
        }
        let noDataError = FrisbeeError.noData
        return Result.fail(noDataError)
    }
}
