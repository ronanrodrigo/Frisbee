import Foundation

final class ResultGenerator<T: Decodable> {

    private let decoder: DecodableAdapter

    init(decoder: DecodableAdapter) {
        self.decoder = decoder
    }

    func generate(data: Data?, error: Error?) -> Result<T> {
        guard let data = data else {
            switch error {
                case .some(URLError.cancelled):
                    return .fail(FrisbeeError.requestCancelled)
                case .some(let error):
                    return .fail(FrisbeeError(error))
                case .none:
                    return .fail(FrisbeeError.noData)
            }
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
