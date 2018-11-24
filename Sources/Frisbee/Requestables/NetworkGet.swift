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
    public func get<T: Decodable>(url: URL, onComplete: @escaping OnComplete<T>) -> Cancellable {
        return makeRequest(url: url, onComplete: onComplete)
    }

    @discardableResult
    public func get<T: Decodable, U: Encodable>(url: URL, query: U,
                                                onComplete: @escaping OnComplete<T>) -> Cancellable {
        //we're only doing this way (instead of returning on the do block) to avoid uncoverage curly brace on tests
        //similar issue: https://stackoverflow.com/questions/34622082/why-is-a-closing-brace-showing-no-code-coverage
        var url = url
        do {
            url = try queryAdapter.build(withUrl: url, query: query)
        } catch {
            onComplete(.fail(FrisbeeError(error)))
            return NilCancellable()
        }

        return makeRequest(url: url, onComplete: onComplete)
    }

    private func makeRequest<T: Decodable>(url: URL, onComplete: @escaping (Result<T>) -> Void) -> Cancellable {
        let request = URLRequestFactory.make(.GET, url)

        return DataTaskRunner.run(with: urlSession, request: request, onComplete: onComplete)
    }

}
