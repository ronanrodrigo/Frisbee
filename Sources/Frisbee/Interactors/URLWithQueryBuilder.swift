import Foundation

struct URLWithQueryBuilder: URLWithQueryBuildable {

    func build<T: Encodable>(withUrl url: String, query: T) throws -> URL {
        guard let actualUrl = URL(string: url) else {
            throw FrisbeeError.invalidUrl
        }
        return try build(withUrl: actualUrl, query: query)
    }

    func build<T: Encodable>(withUrl url: URL, query: T) throws -> URL {
        var url = url
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = try QueryItemBuilder.build(withEntity: query)

        if let componentsUrl = urlComponents?.url { url = componentsUrl }

        return url
    }
}
