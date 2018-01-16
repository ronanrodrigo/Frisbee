import Foundation

public protocol Getable {
    func get<T: Decodable>(url: String, onComplete: @escaping OnComplete<T>)
    func get<T: Decodable>(url: URL, onComplete: @escaping OnComplete<T>)
    func get<T: Decodable, U: Encodable>(url: String, query: U, onComplete: @escaping OnComplete<T>)
    func get<T: Decodable, U: Encodable>(url: URL, query: U, onComplete: @escaping OnComplete<T>)
}
