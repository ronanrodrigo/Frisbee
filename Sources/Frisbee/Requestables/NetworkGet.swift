import Foundation

@available(*, deprecated, message: "use NetworkGet")
typealias NetworkGetter = NetworkGet

public final class NetworkGet: Getable {

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

    @discardableResult
    public func get<T: Decodable>(url: String, onComplete: @escaping OnComplete<T>) -> Cancellable {
        guard let url = URL(string: url) else {
            onComplete(.fail(FrisbeeError.invalidUrl))
            return NilCancellable()
        }
        return makeRequest(url: url, onComplete: onComplete)
    }

    @discardableResult
    public func get<T: Decodable>(url: URL, onComplete: @escaping OnComplete<T>) -> Cancellable {
        return makeRequest(url: url, onComplete: onComplete)
    }

    @discardableResult
    public func get<T: Decodable, U: Encodable>(url: String, query: U,
                                                onComplete: @escaping OnComplete<T>) -> Cancellable {
        guard let url = URL(string: url) else {
            onComplete(.fail(FrisbeeError.invalidUrl))
            return NilCancellable()
        }
        return get(url: url, query: query, onComplete: onComplete)
    }

    @discardableResult
    public func get<T: Decodable, U: Encodable>(url: URL, query: U,
                                                onComplete: @escaping OnComplete<T>) -> Cancellable {
        do {
            let url = try queryAdapter.build(withUrl: url, query: query)
            return makeRequest(url: url, onComplete: onComplete)
        } catch {
            onComplete(.fail(FrisbeeError(error)))
            return NilCancellable()
        }
    }

    private func makeRequest<T: Decodable>(url: URL, onComplete: @escaping (Result<T>) -> Void) -> Cancellable {
        let request = URLRequestFactory.make(.GET, url)

        return DataTaskRunner.run(with: urlSession, request: request, onComplete: onComplete)
    }

}
