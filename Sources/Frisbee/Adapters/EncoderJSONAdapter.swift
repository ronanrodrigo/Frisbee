import Foundation

final class EncoderJSONAdapter: EncodableAdapter {
    func encode<T: Encodable>(_ value: T) throws -> Data {
        return try JSONEncoder().encode(value)
    }
}
