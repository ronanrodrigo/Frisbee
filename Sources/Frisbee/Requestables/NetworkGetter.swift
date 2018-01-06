import Foundation

public class NetworkGetter: Getable {

    let urlSession: URLSession

    public init() {
        self.urlSession = URLSessionFactory.make()
    }

    public init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    public func get<Entity: Decodable>(url: String, onComplete: @escaping (Result<Entity>) -> Void) {
        guard let url = URL(string: url) else {
            return onComplete(.fail(FrisbeeError.invalidUrl))
        }
        makeRequest(url: url, onComplete: onComplete)
    }

    public func get<Entity: Decodable, Query: Encodable>(url: String, query: Query,
                                                         onComplete: @escaping (Result<Entity>) -> Void) {
        do {
            let url = try URLWithQueryBuilder.build(withUrl: url, query: query)
            makeRequest(url: url, onComplete: onComplete)
        } catch where type(of: error) == FrisbeeError.self {
            let error = error as? FrisbeeError ?? .unknown
            return onComplete(.fail(error))
        } catch {
            return onComplete(.fail(.other(localizedDescription: error.localizedDescription)))
        }
    }

    private func makeRequest<Entity: Decodable>(url: URL, onComplete: @escaping (Result<Entity>) -> Void) {
        let request = URLRequestFactory.make(.GET, url)

        let task = urlSession.dataTask(with: request) { data, _, error in
            onComplete(ResultGenerator.generate(data: data, error: error))
        }

        task.resume()
        urlSession.finishTasksAndInvalidate()
    }

}
