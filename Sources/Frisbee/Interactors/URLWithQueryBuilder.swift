import Foundation

struct URLWithQueryBuilder {

    static func build<Query: Encodable>(withUrl url: String, query: Query) throws -> URL {
        let queryItems = try QueryItemBuilder.build(withEntity: query)
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = queryItems

        guard let url = urlComponents?.url else {
            throw FrisbeeError.invalidUrl
        }
        return url
    }

}
