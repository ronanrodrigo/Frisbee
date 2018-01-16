import Foundation

protocol EncodableAdapter {
    func encode<T: Encodable>(_ value: T) throws -> Data
}
