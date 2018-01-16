import Foundation
@testable import Frisbee

class SerializerThrowErrorFakeAdapter: SerializableAdapter {
    func object(with data: Data, options opt: JSONSerialization.ReadingOptions = []) throws -> Any {
        throw FrisbeeError.invalidEntity
    }
}
