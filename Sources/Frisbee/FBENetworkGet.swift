import Foundation

public class FBENetworkGet: FBEGetable {

    public static func get(url: String, completionHandler: @escaping (FBEResult) -> Void) {
        guard let url = URL(string: url) else {
            return completionHandler(.error(FBEError.invalidUrl))
        }
        get(url: url, completionHandler: completionHandler)
    }

    public static func get(url: URL, completionHandler: @escaping (FBEResult) -> Void) {
        makeRequest(url: url, completionHandler: completionHandler)
    }

    private static func makeRequest(url: URL, completionHandler: @escaping (FBEResult) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = session.dataTask(with: request) { data, _, error in
            completionHandler(FBEResultGenerator.generateResult(data: data, error: error))
        }

        task.resume()
        session.finishTasksAndInvalidate()
    }

}
