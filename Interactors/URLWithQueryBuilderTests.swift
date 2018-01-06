import XCTest
@testable import Frisbee

class URLWithQueryBuilderTests: XCTestCase {

    struct MovieQuery: Encodable {
        let page: Int
        let keyAccess: String
        let optionalInt: Int?

        // swiftlint:disable:next nesting
        enum CodingKeys: String, CodingKey {
            case page, keyAccess = "key_access", optionalInt = "optional_int"
        }
    }

    func testBuildURLWhenHasCorrectQueryWithNilValueThenGenerateURLWithQueryStrings() {
        let query = MovieQuery(page: 1, keyAccess: "a1d13so979", optionalInt: nil)
        let url = "http://www.com.br"

        let builtUrl = try? URLWithQueryBuilder.build(withUrl: url, query: query)

        XCTAssertEqual(builtUrl?.absoluteString, "\(url)?page=\(query.page)&key_access=\(query.keyAccess)")
    }

    func testBuildURLWhenHasCorrectQueryWithoutNilValueThenGenerateURLWithQueryStrings() {
        let query = MovieQuery(page: 1, keyAccess: "a1d13so979", optionalInt: 10)
        let url = "http://www.com.br"

        let builtUrl = try? URLWithQueryBuilder.build(withUrl: url, query: query)

        let expectedUrl = "\(url)?optional_int=\(query.optionalInt!)&page=\(query.page)&key_access=\(query.keyAccess)"
        XCTAssertEqual(builtUrl?.absoluteString, expectedUrl)
    }

    func testBuildURLWhenHasInvalidUrlThenThrowInvalidURLError() {
        let query = MovieQuery(page: 1, keyAccess: "a1d13so979", optionalInt: 10)
        let url = "http://www.çøµ.∫®"

        XCTAssertThrowsError(try URLWithQueryBuilder.build(withUrl: url, query: query))
    }

    static var allTests = [
        ("testBuildURLWhenHasCorrectQueryWithNilValueThenGenerateURLWithQueryStrings",
         testBuildURLWhenHasCorrectQueryWithNilValueThenGenerateURLWithQueryStrings),
        ("testBuildURLWhenHasCorrectQueryWithoutNilValueThenGenerateURLWithQueryStrings",
         testBuildURLWhenHasCorrectQueryWithoutNilValueThenGenerateURLWithQueryStrings),
        ("testBuildURLWhenHasInvalidUrlThenThrowInvalidURLError",
         testBuildURLWhenHasInvalidUrlThenThrowInvalidURLError)
    ]

}
