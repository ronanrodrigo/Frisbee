import Foundation

struct BodyBuilder: BodyBuildable {

    func build<Entity: Encodable>(withBody body: Entity) throws -> [String: Any] {
        var json: [String: Any] = [:]

        let data = try JSONEncoder().encode(body)
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        if let jsonDictionary = jsonObject as? [String: Any] { json = jsonDictionary }

        return json
    }

}
