import Foundation

@available(*, deprecated, message: "use NetworkGet")
typealias NetworkGetter = NetworkGet

public class NetworkGet: Getable {

    let urlSession: URLSession
    private let queryBuilder: URLWithQueryBuildable

    public convenience init() {
        self.init(queryBuildable: URLWithQueryBuildableFactory.make(), urlSession: URLSessionFactory.make())
    }

    public convenience init(urlSession: URLSession) {
        self.init(queryBuildable: URLWithQueryBuildableFactory.make(), urlSession: urlSession)
    }

    init(queryBuildable: URLWithQueryBuildable, urlSession: URLSession) {
        self.queryBuilder = queryBuildable
        self.urlSession = urlSession
    }

    public func get<Entity: Decodable>(url: String, onComplete: @escaping (Result<Entity>) -> Void) {
        guard let url = URL(string: url) else {
            return onComplete(.fail(FrisbeeError.invalidUrl))
        }
        makeRequest(url: url, onComplete: onComplete)
    }

    public func get<Entity: Decodable>(url: URL, onComplete: @escaping (Result<Entity>) -> Void) {
        makeRequest(url: url, onComplete: onComplete)
    }

    public func get<Entity: Decodable, Query: Encodable>(url: String, query: Query,
                                                         onComplete: @escaping (Result<Entity>) -> Void) {
        guard let url = URL(string: url) else {
            return onComplete(.fail(FrisbeeError.invalidUrl))
        }
        get(url: url, query: query, onComplete: onComplete)
    }

    public func get<Entity: Decodable, Query: Encodable>(url: URL, query: Query,
                                                         onComplete: @escaping (Result<Entity>) -> Void) {
        do {
            let url = try queryBuilder.build(withUrl: url, query: query)
            makeRequest(url: url, onComplete: onComplete)
        } catch {
            return onComplete(.fail(FrisbeeError(error)))
        }
    }

    private func makeRequest<Entity: Decodable>(url: URL, onComplete: @escaping (Result<Entity>) -> Void) {
        let request = URLRequestFactory.make(.GET, url)

        let task = urlSession.dataTask(with: request) { data, _, error in
            onComplete(ResultGenerator.generate(data: data, error: error))
        }

        task.resume()
    }

}
