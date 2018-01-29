import Foundation

final class URLSessionTaskAdapter: CancellableAdapter {
    private let task: URLSessionTask

    init(task: URLSessionTask) {
        self.task = task
    }

    func cancel() {
        task.cancel()
    }
}
