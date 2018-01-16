import Foundation

public final class NetworkPost: Postable {

    let urlSession: URLSession
    private let bodyBuilder: BodiableAdapter

    public convenience init() {
        self.init(urlSession: URLSessionFactory.make(), bodyBuilder: BodyBuildableFactory.make())
    }

    public convenience init(urlSession: URLSession) {
        self.init(urlSession: urlSession, bodyBuilder: BodyBuildableFactory.make())
    }

    init(urlSession: URLSession, bodyBuilder: BodiableAdapter) {
        self.urlSession = urlSession
        self.bodyBuilder = bodyBuilder
    }

    public func post<T: Decodable>(url: String, onComplete: @escaping OnComplete<T>) {
        guard let url = URL(string: url) else {
            return onComplete(.fail(FrisbeeError.invalidUrl))
        }
        makeRequest(url: url, onComplete: onComplete)
    }

    public func post<T: Decodable>(url: URL, onComplete: @escaping OnComplete<T>) {
        makeRequest(url: url, onComplete: onComplete)
    }

    public func post<T: Decodable, U: Encodable>(url: String, body: U, onComplete: @escaping OnComplete<T>) {
        guard let url = URL(string: url) else {
            return onComplete(.fail(FrisbeeError.invalidUrl))
        }
        makeRequest(url: url, body: body, onComplete: onComplete)
    }

    public func post<T: Decodable, U: Encodable>(url: URL, body: U, onComplete: @escaping OnComplete<T>) {
        makeRequest(url: url, body: body, onComplete: onComplete)
    }

    private func makeRequest<T: Decodable>(url: URL, onComplete: @escaping OnComplete<T>) {
        let request = URLRequestFactory.make(.POST, url)
        DataTaskRunner.run(with: urlSession, request: request, onComplete: onComplete)
    }

    private func makeRequest<T: Decodable, U: Encodable>(url: URL, body: U, onComplete: @escaping OnComplete<T>) {
        var request = URLRequestFactory.make(.POST, url)
        do {
            let bodyObject = try bodyBuilder.build(withBody: body)
            request.httpBody = try JSONSerialization.data(withJSONObject: bodyObject, options: [])
        } catch {
            return onComplete(.fail(FrisbeeError(error)))
        }

        DataTaskRunner.run(with: urlSession, request: request, onComplete: onComplete)
    }

}
