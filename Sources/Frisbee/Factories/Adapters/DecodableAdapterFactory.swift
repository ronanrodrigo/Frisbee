import Foundation

final class DecodableAdapterFactory {

    static func make<T>(_ type: T.Type) -> DecodableAdapter {
        if T.self == Data.self { return DecoderDataAdapter() }
        return DecoderJSONAdapter()
    }

}
