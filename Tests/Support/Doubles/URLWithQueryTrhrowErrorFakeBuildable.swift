import Foundation
@testable import Frisbee

class URLWithQueryTrhrowErrorFakeBuildable: URLWithQueryBuildable {
    var errorToThrow: FrisbeeError!

    func build<Query: Encodable>(withUrl url: String, query: Query) throws -> URL {
        throw errorToThrow
    }

    func build<Query: Encodable>(withUrl url: URL, query: Query) throws -> URL {
        throw errorToThrow
    }
}
