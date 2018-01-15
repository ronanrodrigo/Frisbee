import Foundation
@testable import Frisbee

class FrisbeeThrowErrorFakeDecodable: FrisbeeDecodable {
    private let error = FrisbeeError.invalidEntity

    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        throw error
    }

}
