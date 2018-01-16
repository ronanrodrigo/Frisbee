import Foundation

protocol BodyBuildable {
    func build<T: Encodable>(withBody body: T) throws -> [String: Any]
}
