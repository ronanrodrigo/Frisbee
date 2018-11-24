import Foundation

public protocol Putable {
    @discardableResult
    func put<T: Decodable>(url: URL, onComplete: @escaping OnComplete<T>) -> Cancellable
    @discardableResult
    func put<T: Decodable, U: Encodable>(url: URL, body: U, onComplete: @escaping OnComplete<T>) -> Cancellable
}

extension Putable {
    @discardableResult
    public func put<T: Decodable>(url: String, onComplete: @escaping OnComplete<T>) -> Cancellable {
        guard let url = URL(string: url) else {
            onComplete(.fail(FrisbeeError.invalidUrl))
            return NilCancellable()
        }
        return put(url: url, onComplete: onComplete)
    }

    @discardableResult
    public func put<T: Decodable, U: Encodable>(url: String, body: U,
                                                onComplete: @escaping OnComplete<T>) -> Cancellable {
        guard let url = URL(string: url) else {
            onComplete(.fail(FrisbeeError.invalidUrl))
            return NilCancellable()
        }
        return put(url: url, body: body, onComplete: onComplete)
    }
}
