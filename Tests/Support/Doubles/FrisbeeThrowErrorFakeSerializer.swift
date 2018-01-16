import Foundation
@testable import Frisbee

class FrisbeeThrowErrorFakeSerializer: FrisbeeSerializable {
    func object(with data: Data, options opt: JSONSerialization.ReadingOptions = []) throws -> Any {
        throw FrisbeeError.invalidEntity
    }
}
