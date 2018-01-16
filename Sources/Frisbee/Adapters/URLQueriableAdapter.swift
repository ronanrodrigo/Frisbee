import Foundation

protocol URLQueriableAdapter {
    func build<T: Encodable>(withUrl url: String, query: T) throws -> URL
    func build<T: Encodable>(withUrl url: URL, query: T) throws -> URL
}
