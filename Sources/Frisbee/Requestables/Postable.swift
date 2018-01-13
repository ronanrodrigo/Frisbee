import Foundation

protocol Postable {
    func post<Entity: Decodable>(url: String, onComplete: @escaping (Result<Entity>) -> Void)
    func post<Entity: Decodable>(url: URL, onComplete: @escaping (Result<Entity>) -> Void)
    func post<Entity: Decodable, Body: Encodable>(url: String, body: Body,
                                                  onComplete: @escaping (Result<Entity>) -> Void)
    func post<Entity: Decodable, Body: Encodable>(url: URL, body: Body,
                                                  onComplete: @escaping (Result<Entity>) -> Void)
}
