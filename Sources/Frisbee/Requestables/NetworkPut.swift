import Foundation

public final class NetworkPut: Putable {

    let urlSession: URLSession
    private let bodyAdapter: BodiableAdapter

    public convenience init() {
        self.init(urlSession: URLSessionFactory.make(), bodyAdapter: BodyAdapterFactory.make())
    }

    public convenience init(urlSession: URLSession) {
        self.init(urlSession: urlSession, bodyAdapter: BodyAdapterFactory.make())
    }

    init(urlSession: URLSession, bodyAdapter: BodiableAdapter) {
        self.urlSession = urlSession
        self.bodyAdapter = bodyAdapter
    }

    @discardableResult
    public func put<T: Decodable>(url: URL, onComplete: @escaping OnComplete<T>) -> Cancellable {
        return makeRequest(url: url, onComplete: onComplete)
    }

    @discardableResult
    public func put<T: Decodable, U: Encodable>(url: URL, body: U,
                                                onComplete: @escaping OnComplete<T>) -> Cancellable {
        return makeRequest(url: url, body: body, onComplete: onComplete)
    }

    private func makeRequest<T: Decodable>(url: URL, onComplete: @escaping OnComplete<T>) -> Cancellable {
        let request = URLRequestFactory.make(.PUT, url)
        return DataTaskRunner.run(with: urlSession, request: request, onComplete: onComplete)
    }

    private func makeRequest<T: Decodable, U: Encodable>(url: URL, body: U,
                                                         onComplete: @escaping OnComplete<T>) -> Cancellable {
        var request = URLRequestFactory.make(.PUT, url)
        do {
            let bodyObject = try bodyAdapter.build(withBody: body)
            request.httpBody = try JSONSerialization.data(withJSONObject: bodyObject, options: [])
        } catch {
            onComplete(.fail(FrisbeeError(error)))
            return NilCancellable()
        }

        return DataTaskRunner.run(with: urlSession, request: request, onComplete: onComplete)
    }

}
