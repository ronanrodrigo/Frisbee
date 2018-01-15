import Foundation

struct BodyBuilder: BodyBuildable {

    func build<T: Encodable>(withBody body: T) throws -> [String: Any] {
        var json: [String: Any] = [:]

        let data = try JSONEncoder().encode(body)
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        if let jsonDictionary = jsonObject as? [String: Any] { json = jsonDictionary }

        return json
    }

}
