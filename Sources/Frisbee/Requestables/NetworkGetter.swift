import Foundation

public class NetworkGetter: Getable {

    public init() { }

    public func get<Entity: Decodable>(url: String, completionHandler: @escaping (Result<Entity>) -> Void) {
        guard let url = URL(string: url) else {
            return completionHandler(.fail(FrisbeeError.invalidUrl))
        }
        get(url: url, completionHandler: completionHandler)
    }

    public func get<Entity: Decodable>(url: URL, completionHandler: @escaping (Result<Entity>) -> Void) {
        makeRequest(url: url, completionHandler: completionHandler)
    }

    private func makeRequest<Entity: Decodable>(url: URL, completionHandler: @escaping (Result<Entity>) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = session.dataTask(with: request) { data, _, error in
            completionHandler(ResultGenerator.generate(data: data, error: error))
        }

        task.resume()
        session.finishTasksAndInvalidate()
    }

}
