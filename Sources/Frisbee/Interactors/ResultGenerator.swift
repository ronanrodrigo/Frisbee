import Foundation

struct ResultGenerator<Entity: Decodable> {

    private let decoder: FrisbeeDecodable

    init(decoder: FrisbeeDecodable) {
        self.decoder = decoder
    }

    func generate(data: Data?, error: Error?) -> Result<Entity> {
        if let data = data {
            let result: Result<Entity>
            do {
                let entityDecoded = try decoder.decode(Entity.self, from: data)
                result = Result.success(entityDecoded)
            } catch {
                let noDataError = FrisbeeError.noData
                result = Result.fail(noDataError)
            }
            return result
        } else if let error = error {
            let otherError = FrisbeeError.other(localizedDescription: error.localizedDescription)
            return Result.fail(otherError)
        }
        let noDataError = FrisbeeError.noData
        return Result.fail(noDataError)
    }

}
