import Foundation

struct URLWithQueryBuilder {

    static func build<Query: Encodable>(withUrl url: String, query: Query) throws -> URL {
        guard let actualUrl = URL(string: url) else {
            throw FrisbeeError.invalidUrl
        }
        return try build(withUrl: actualUrl, query: query)
    }

    static func build<Query: Encodable>(withUrl url: URL, query: Query) throws -> URL {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = try QueryItemBuilder.build(withEntity: query)

        guard let url = urlComponents?.url else {
            throw FrisbeeError.invalidUrl
        }
        return url
    }
}
