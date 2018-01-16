import Foundation
@testable import Frisbee

struct BodyThrowErrorFakeBuilder: BodiableAdapter {
    private let errorToThrow = FrisbeeError.invalidEntity

    func build<T: Encodable>(withBody body: T) throws -> [String: Any] {
        throw errorToThrow
    }
}
