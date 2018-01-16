import Foundation

@available(*, deprecated, message: "use NetworkGet")
typealias NetworkGetter = NetworkGet

public class NetworkGet: Getable {

    let urlSession: URLSession
    private let queryAdapter: URLQueriableAdapter

    public convenience init() {
        self.init(queryAdapter: URLQueriableAdapterFactory.make(), urlSession: URLSessionFactory.make())
    }

    public convenience init(urlSession: URLSession) {
        self.init(queryAdapter: URLQueriableAdapterFactory.make(), urlSession: urlSession)
    }

    init(queryAdapter: URLQueriableAdapter, urlSession: URLSession) {
        self.queryAdapter = queryAdapter
        self.urlSession = urlSession
    }

    public func get<T: Decodable>(url: String, onComplete: @escaping OnComplete<T>) {
        guard let url = URL(string: url) else {
            return onComplete(.fail(FrisbeeError.invalidUrl))
        }
        makeRequest(url: url, onComplete: onComplete)
    }

    public func get<T: Decodable>(url: URL, onComplete: @escaping OnComplete<T>) {
        makeRequest(url: url, onComplete: onComplete)
    }

    public func get<T: Decodable, U: Encodable>(url: String, query: U, onComplete: @escaping OnComplete<T>) {
        guard let url = URL(string: url) else {
            return onComplete(.fail(FrisbeeError.invalidUrl))
        }
        get(url: url, query: query, onComplete: onComplete)
    }

    public func get<T: Decodable, U: Encodable>(url: URL, query: U, onComplete: @escaping OnComplete<T>) {
        do {
            let url = try queryAdapter.build(withUrl: url, query: query)
            makeRequest(url: url, onComplete: onComplete)
        } catch {
            return onComplete(.fail(FrisbeeError(error)))
        }
    }

    private func makeRequest<T: Decodable>(url: URL, onComplete: @escaping (Result<T>) -> Void) {
        let request = URLRequestFactory.make(.GET, url)

        DataTaskRunner.run(with: urlSession, request: request, onComplete: onComplete)
    }

}
