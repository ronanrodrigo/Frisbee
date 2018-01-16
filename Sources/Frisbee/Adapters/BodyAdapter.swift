import Foundation

struct BodyAdapter: BodiableAdapter {

    private let encoder: EncodableAdapter
    private let serializer: SerializableAdapter

    init(encoder: EncodableAdapter, serializer: SerializableAdapter) {
        self.encoder = encoder
        self.serializer = serializer
    }

    func build<T: Encodable>(withBody body: T) throws -> [String: Any] {
        var json: [String: Any] = [:]

        let data = try encoder.encode(body)
        let jsonObject = try serializer.object(with: data, options: [])
        if let jsonDictionary = jsonObject as? [String: Any] { json = jsonDictionary }

        return json
    }

}
