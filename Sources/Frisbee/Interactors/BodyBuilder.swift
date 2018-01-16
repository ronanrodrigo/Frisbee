import Foundation

struct BodyBuilder: BodyBuildable {

    private let encoder: FrisbeeEncodable
    private let serializer: FrisbeeSerializable

    init(encoder: FrisbeeEncodable, serializer: FrisbeeSerializable) {
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
