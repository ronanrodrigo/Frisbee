import Foundation
@testable import Frisbee

class EncoderThrowErrorFakeAdapter: EncodableAdapter {
    func encode<T: Encodable>(_ value: T) throws -> Data {
        throw FrisbeeError.invalidEntity
    }
}
