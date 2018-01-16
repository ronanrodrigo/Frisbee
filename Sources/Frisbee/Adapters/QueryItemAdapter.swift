import Foundation

struct QueryItemAdapter<T: Encodable> {

    static func build(withEntity entity: T) throws -> [URLQueryItem] {
        var json: [String: Any] = [:]

        let data = try JSONEncoder().encode(entity)
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        if let jsonDictionary = jsonObject as? [String: Any] { json = jsonDictionary }

        return json.map { keyAndValue -> URLQueryItem in
            let value = String(describing: keyAndValue.value)
            return URLQueryItem(name: keyAndValue.key, value: value)
        }
    }

}
