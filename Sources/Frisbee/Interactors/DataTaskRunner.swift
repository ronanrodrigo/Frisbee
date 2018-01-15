import Foundation

final class DataTaskRunner {

    static func run<T: Decodable>(with urlSession: URLSession, request: URLRequest,
                                  onComplete: @escaping OnComplete<T>) {
        let task = urlSession.dataTask(with: request) { data, _, error in
            onComplete(ResultGeneratorFactory.make().generate(data: data, error: error))
        }

        task.resume()
    }

}
