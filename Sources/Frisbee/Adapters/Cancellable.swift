public protocol Cancellable {
    func cancel()
}

final class NilCancellable: Cancellable {
    func cancel() {}
}
