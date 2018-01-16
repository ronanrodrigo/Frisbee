import Foundation

protocol Postable {
    func post<T: Decodable>(url: String, onComplete: @escaping OnComplete<T>)
    func post<T: Decodable>(url: URL, onComplete: @escaping OnComplete<T>)
    func post<T: Decodable, U: Encodable>(url: String, body: U, onComplete: @escaping OnComplete<T>)
    func post<T: Decodable, U: Encodable>(url: URL, body: U, onComplete: @escaping OnComplete<T>)
}
