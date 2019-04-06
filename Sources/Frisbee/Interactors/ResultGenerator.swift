import Foundation

final class ResultGenerator<T: Decodable> {

    private let decoder: DecodableAdapter

    init(decoder: DecodableAdapter) {
        self.decoder = decoder
    }

    func generate(data: Data?, urlResponse: URLResponse?, error: Error?) -> Result<T> {
        guard let urlResponse = urlResponse else {
            switch error {
            case .some(let error): return .fail(FrisbeeError(error))
            case .none: return .fail(FrisbeeError.noData)
            }
        }

        do {
            let entityDecoded = try decoder.decode(T.self, from: data)

            if urlResponse is HTTPURLResponse {
                return .success(entityDecoded, (urlResponse as! HTTPURLResponse).statusCode)
            }
            return .success(entityDecoded, nil)
        } catch { return .fail(.noData) }
    }

}
