import Foundation

public protocol Postable {
    @discardableResult
    func post<T: Decodable>(url: URL, onComplete: @escaping OnComplete<T>) -> Cancellable
    @discardableResult
    func post<T: Decodable, U: Encodable>(url: URL, body: U, onComplete: @escaping OnComplete<T>) -> Cancellable
}

extension Postable {
    @discardableResult
    public func post<T: Decodable>(url: String, onComplete: @escaping OnComplete<T>) -> Cancellable {
        guard let url = URL(string: url) else {
            onComplete(.fail(FrisbeeError.invalidUrl))
            return NilCancellable()
        }
        return post(url: url, onComplete: onComplete)
    }

    @discardableResult
    public func post<T: Decodable, U: Encodable>(url: String, body: U,
                                                 onComplete: @escaping OnComplete<T>) -> Cancellable {
        guard let url = URL(string: url) else {
            onComplete(.fail(FrisbeeError.invalidUrl))
            return NilCancellable()
        }
        return post(url: url, body: body, onComplete: onComplete)
    }
}
