import Foundation

final class DataTaskRunner {

    static func run<T: Decodable>(with urlSession: URLSession, request: URLRequest,
                                  onComplete: @escaping OnComplete<T>) -> Cancellable {
        let task = urlSession.dataTask(with: request) { data, urlResponse, error in
            onComplete(ResultGeneratorFactory.make().generate(data: data, urlResponse: urlResponse, error: error))
        }
        task.resume()
        return URLSessionTaskAdapter(task: task)
    }

}
