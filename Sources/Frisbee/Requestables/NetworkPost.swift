import Foundation

public final class NetworkPost: Postable {

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
    public func post<T: Decodable>(url: String, onComplete: @escaping OnComplete<T>) -> Cancellable {
        guard let url = URL(string: url) else {
            onComplete(.fail(FrisbeeError.invalidUrl))
            return NilCancellable()
        }
        return post(url: url, onComplete: onComplete)
    }

    @discardableResult
    public func post<T: Decodable>(url: URL, onComplete: @escaping OnComplete<T>) -> Cancellable {
        return makeRequest(url: url, onComplete: onComplete)
    }

    @discardableResult
    public func post<T: Decodable, U: Encodable>(url: String, body: U,
                                                 onComplete: @escaping OnComplete<T>) -> Cancellable {
        guard let url = URL(string: url) else {
            onComplete(.fail(FrisbeeError.invalidUrl))
            return NilCancellable()
        }
        return post(url: url, body: body, onComplete: onComplete)
    }

    @discardableResult
    public func post<T: Decodable, U: Encodable>(url: URL, body: U,
                                                 onComplete: @escaping OnComplete<T>) -> Cancellable {
        return makeRequest(url: url, body: body, onComplete: onComplete)
    }

    private func makeRequest<T: Decodable>(url: URL, onComplete: @escaping OnComplete<T>) -> Cancellable {
        let request = URLRequestFactory.make(.POST, url)
        return DataTaskRunner.run(with: urlSession, request: request, onComplete: onComplete)
    }

    private func makeRequest<T: Decodable, U: Encodable>(url: URL, body: U,
                                                         onComplete: @escaping OnComplete<T>) -> Cancellable {
        var request = URLRequestFactory.make(.POST, url)
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
