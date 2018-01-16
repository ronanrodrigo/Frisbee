import Foundation

class JSONSerializerAdapter: SerializableAdapter {
    func object(with data: Data, options opt: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: data, options: opt)
    }
}
