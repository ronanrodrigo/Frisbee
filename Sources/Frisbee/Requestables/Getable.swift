import Foundation

public protocol Getable {
    func get<Entity: Decodable>(url: URL, completionHandler: @escaping (Result<Entity>) -> Void)
    func get<Entity: Decodable>(url: String, completionHandler: @escaping (Result<Entity>) -> Void)
}
