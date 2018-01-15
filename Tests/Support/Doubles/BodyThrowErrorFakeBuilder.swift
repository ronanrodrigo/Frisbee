import Foundation
@testable import Frisbee

struct BodyThrowErrorFakeBuilder: BodyBuildable {
    private let errorToThrow = FrisbeeError.invalidEntity

    func build<T: Encodable>(withBody body: T) throws -> [String: Any] {
        throw errorToThrow
    }
}
