import Foundation

protocol Postable {
    @discardableResult
    func post<T: Decodable>(url: String,
                            onComplete: @escaping OnComplete<T>) -> Cancellable
    @discardableResult
    func post<T: Decodable>(url: URL,
                            onComplete: @escaping OnComplete<T>) -> Cancellable
    @discardableResult
    func post<T: Decodable, U: Encodable>(url: String, body: U,
                                          onComplete: @escaping OnComplete<T>) -> Cancellable
    @discardableResult
    func post<T: Decodable, U: Encodable>(url: URL, body: U,
                                          onComplete: @escaping OnComplete<T>) -> Cancellable
}
