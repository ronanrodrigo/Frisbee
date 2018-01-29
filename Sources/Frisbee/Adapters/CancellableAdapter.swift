public protocol CancellableAdapter {
    func cancel()
}

final class NilCancellable: CancellableAdapter {
    func cancel() {}
}
