import Foundation

final class DecoderDataAdapter: DecodableAdapter {
    func decode<T: Decodable>(_ type: T.Type, from data: Data?) throws -> T? {
        if let data = data as? T? { return data }
        throw FrisbeeError.invalidEntity
    }

}
