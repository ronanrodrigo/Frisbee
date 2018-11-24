import Foundation

final class ResultGenerator<T: Decodable> {

    private let decoder: DecodableAdapter

    init(decoder: DecodableAdapter) {
        self.decoder = decoder
    }

    func generate(data: Data?, error: Error?) -> Result<T> {
        guard let data = data else {
            switch error {
            case .some(let error): return .fail(FrisbeeError(error))
            case .none: return .fail(FrisbeeError.noData)
            }
        }

        do {
            let entityDecoded = try decoder.decode(T.self, from: data)
            return .success(entityDecoded)
        } catch { return .fail(.noData) }
    }

}
