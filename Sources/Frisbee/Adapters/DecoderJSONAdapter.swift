import Foundation

final class DecoderJSONAdapter: DecodableAdapter {
    let decoder: JSONDecoder

    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }

    func decode<T: Decodable>(_ type: T.Type, from data: Data?) throws -> T? {
        if let data = data {
            return try decoder.decode(type, from: data)
        }

        return nil
    }

}
