import Foundation

final class URLSessionTaskAdapter: Cancellable {
    private let task: URLSessionTask

    init(task: URLSessionTask) {
        self.task = task
    }

    func cancel() {
        task.cancel()
    }
}
