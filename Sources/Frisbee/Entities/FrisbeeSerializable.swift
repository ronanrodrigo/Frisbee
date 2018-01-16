import Foundation

protocol FrisbeeSerializable {
    func object(with data: Data, options opt: JSONSerialization.ReadingOptions) throws -> Any
}
