import Foundation
@testable import Frisbee

class FrisbeeThrowErrorFakeEncoder: FrisbeeEncodable {
    func encode<T: Encodable>(_ value: T) throws -> Data {
        throw FrisbeeError.invalidEntity
    }
}
