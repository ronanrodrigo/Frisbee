import Foundation

public protocol FBEGetable {
    func get<Entity: Decodable>(url: URL, completionHandler: @escaping (FBEResult<Entity>) -> Void)
    func get<Entity: Decodable>(url: String, completionHandler: @escaping (FBEResult<Entity>) -> Void)
}
