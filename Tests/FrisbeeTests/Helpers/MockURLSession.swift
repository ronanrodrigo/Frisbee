import Foundation
#if !os(Linux)
typealias URLSessionCallback = (Data?, URLResponse?, Error?) -> Void

enum MockError: Error {
    case noMockAvailable
}

class MockURLSession: URLSession {
    // not thread safe, make sure tests do not call this on background
    // or implement a locking mechanism
    var results: [MockDataTask.Result]

    init(results: [MockDataTask.Result] = []) {
        self.results = results
        super.init()
    }

    override func dataTask(with request: URLRequest,
                           completionHandler: @escaping URLSessionCallback) -> URLSessionDataTask {
        guard !results.isEmpty else {
            return MockDataTask(result: .error(MockError.noMockAvailable),
                                callback: completionHandler)
        }

        let result = results.removeFirst()
        return MockDataTask(result: result, callback: completionHandler)
    }
}

class MockDataTask: URLSessionDataTask {
    enum Result {
        case success(Data, URLResponse), error(Error)
    }

    let result: Result
    let callback: (Data?, URLResponse?, Error?) -> Void

    init(result: Result, callback: @escaping URLSessionCallback) {
        self.result = result
        self.callback = callback
        super.init()
    }

    override func resume() {
        switch result {
        case let .success(data, response):
            callback(data, response, nil)
        case let .error(error):
            callback(nil, nil, error)
        }
    }
}
#endif
