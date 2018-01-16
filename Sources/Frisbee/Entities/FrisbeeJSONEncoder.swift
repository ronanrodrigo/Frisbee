import Foundation

class FrisbeeJSONEncoder: FrisbeeEncodable {
    func encode<T: Encodable>(_ value: T) throws -> Data {
        return try JSONEncoder().encode(value)
    }
}
