import Foundation

protocol BodiableAdapter {
    func build<T: Encodable>(withBody body: T) throws -> [String: Any]
}
