import Foundation

final class EncoderJSONAdapter: EncodableAdapter {

    let encoder: JSONEncoder

    init(encoder: JSONEncoder = JSONEncoder()) {
        self.encoder = encoder
    }

    func encode<T: Encodable>(_ value: T) throws -> Data {
        return try encoder.encode(value)
    }
}
