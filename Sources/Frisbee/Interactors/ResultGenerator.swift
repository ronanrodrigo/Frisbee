import Foundation

final class ResultGenerator<T: Decodable> {

    private let decoder: DecodableAdapter

    init(decoder: DecodableAdapter) {
        self.decoder = decoder
    }

    func generate(data: Data?, error: Error?) -> Result<T> {
        guard let data = data else {
            let frisbeeError = FrisbeeError(error ?? FrisbeeError.noData)
            return .fail(frisbeeError)
        }

        let result: Result<T>
        do {
            let entityDecoded = try decoder.decode(T.self, from: data)
            result = .success(entityDecoded)
        } catch {
            result = .fail(.noData)
        }
        return result
    }

}
