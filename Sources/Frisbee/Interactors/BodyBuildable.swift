import Foundation

protocol BodyBuildable {
    func build<Entity: Encodable>(withBody body: Entity) throws -> [String: Any]
}
