import Foundation

final class DecoderAdapter: DecodableAdapter {

    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        return try JSONDecoder().decode(type, from: data)
    }

}
