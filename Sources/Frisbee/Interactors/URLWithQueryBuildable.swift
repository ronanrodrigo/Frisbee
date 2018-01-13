import Foundation

protocol URLWithQueryBuildable {
    func build<Query: Encodable>(withUrl url: String, query: Query) throws -> URL
    func build<Query: Encodable>(withUrl url: URL, query: Query) throws -> URL
}
