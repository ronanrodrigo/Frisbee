import Foundation

public final class NetworkPost: Postable {

    let urlSession: URLSession

    public init() {
        self.urlSession = URLSessionFactory.make()
    }

    public init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    public func post<Entity: Decodable>(url: String, onComplete: @escaping (Result<Entity>) -> Void) {
        guard let url = URL(string: url) else {
            return onComplete(.fail(FrisbeeError.invalidUrl))
        }
        makeRequest(url: url, onComplete: onComplete)
    }

    public func post<Entity: Decodable>(url: URL, onComplete: @escaping (Result<Entity>) -> Void) {
        makeRequest(url: url, onComplete: onComplete)
    }

    public func post<Entity: Decodable, Body: Encodable>(url: String, body: Body,
                                                         onComplete: @escaping (Result<Entity>) -> Void) {
        guard let url = URL(string: url) else {
            return onComplete(.fail(FrisbeeError.invalidUrl))
        }
        makeRequest(url: url, onComplete: onComplete)
    }

    public func post<Entity: Decodable, Body: Encodable>(url: URL, body: Body,
                                                         onComplete: @escaping (Result<Entity>) -> Void) {
        makeRequest(url: url, onComplete: onComplete)
    }

    private func makeRequest<Entity: Decodable>(url: URL, onComplete: @escaping (Result<Entity>) -> Void) {
        let request = URLRequestFactory.make(.POST, url)

        let task = urlSession.dataTask(with: request) { data, _, error in
            onComplete(ResultGeneratorFactory.make().generate(data: data, error: error))
        }

        task.resume()
    }

}
