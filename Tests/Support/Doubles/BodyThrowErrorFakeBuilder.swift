import Foundation
@testable import Frisbee

struct BodyThrowErrorFakeBuilder: BodyBuildable {
    private let errorToThrow = FrisbeeError.invalidEntity

    func build<Entity: Encodable>(withBody body: Entity) throws -> [String: Any] {
        throw errorToThrow
    }
}
