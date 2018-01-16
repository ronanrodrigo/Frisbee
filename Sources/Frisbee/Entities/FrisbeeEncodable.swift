import Foundation

protocol FrisbeeEncodable {
    func encode<T: Encodable>(_ value: T) throws -> Data
}
