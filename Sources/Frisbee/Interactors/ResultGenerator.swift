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

        do {
            let entityDecoded = try decoder.decode(T.self, from: data)
            return .success(entityDecoded)
        } catch {
            return .fail(.noData)
        }
    }

}

