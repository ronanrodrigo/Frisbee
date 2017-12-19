import Foundation

struct QueryItemBuilder {

    static func build(query: [String: Any]) -> [URLQueryItem] {
        return query.map { keyAndValue -> URLQueryItem in
            let value = String(describing: keyAndValue.value)
            return URLQueryItem(name: keyAndValue.key, value: value)
        }
    }

}
