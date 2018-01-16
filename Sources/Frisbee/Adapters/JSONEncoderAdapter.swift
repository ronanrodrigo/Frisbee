import Foundation

final class JSONEncoderAdapter: EncodableAdapter {
    func encode<T: Encodable>(_ value: T) throws -> Data {
        return try JSONEncoder().encode(value)
    }
}
