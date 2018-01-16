import Foundation

protocol SerializableAdapter {
    func object(with data: Data, options opt: JSONSerialization.ReadingOptions) throws -> Any
}
