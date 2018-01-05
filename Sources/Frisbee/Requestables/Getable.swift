import Foundation

public protocol Getable {
    func get<Entity: Decodable>(url: String, onComplete: @escaping (Result<Entity>) -> Void)
    func get<Entity: Decodable>(url: URL, onComplete: @escaping (Result<Entity>) -> Void)
    func get<Entity: Decodable, Query: Encodable>(url: String, query: Query,
                                                  onComplete: @escaping (Result<Entity>) -> Void)
    func get<Entity: Decodable, Query: Encodable>(url: URL, query: Query,
                                                  onComplete: @escaping (Result<Entity>) -> Void)
}
