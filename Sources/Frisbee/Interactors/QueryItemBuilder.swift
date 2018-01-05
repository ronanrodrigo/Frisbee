import Foundation

struct QueryItemBuilder<Entity: Encodable> {

    static func build(withEntity entity: Entity) throws -> [URLQueryItem] {
        let data = try JSONEncoder().encode(entity)
        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw FrisbeeError.invalidEntity
        }

        return json.map { keyAndValue -> URLQueryItem in
            let value = String(describing: keyAndValue.value)
            return URLQueryItem(name: keyAndValue.key, value: value)
        }
    }

}
