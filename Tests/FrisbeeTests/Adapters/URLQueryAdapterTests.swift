import XCTest
@testable import Frisbee

class URLQueryAdapterTests: XCTestCase {

    private var urlWithQueryAdapter: URLQueriableAdapter!

    override func setUp() {
        super.setUp()
        urlWithQueryAdapter = URLQueriableAdapterFactory.make()
    }

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
        guard let url = URL(string: "http://www.com.br") else {
            return XCTFail("Invalid URL")
        }

        let builtUrl = try? urlWithQueryAdapter.build(withUrl: url, query: query)

        XCTAssertTrue(builtUrl?.absoluteString.starts(with: url.absoluteString) ?? false)
        XCTAssertEqual("\(query.page)", getQueryValue(builtUrl?.absoluteString, "page"))
        XCTAssertEqual("\(query.keyAccess)", getQueryValue(builtUrl?.absoluteString, "key_access"))
        XCTAssertNil(getQueryValue(builtUrl?.absoluteString, "optional_int"))
    }

    func testBuildStringURLWhenHasCorrectQueryWithNilValueThenGenerateURLWithQueryStrings() {
        let query = MovieQuery(page: 1, keyAccess: "a1d13so979", optionalInt: nil)
        let url = "http://www.com.br"

        let builtUrl = try? urlWithQueryAdapter.build(withUrl: url, query: query)

        XCTAssertTrue(builtUrl?.absoluteString.starts(with: url) ?? false)
        XCTAssertEqual("\(query.page)", getQueryValue(builtUrl?.absoluteString, "page"))
        XCTAssertEqual("\(query.keyAccess)", getQueryValue(builtUrl?.absoluteString, "key_access"))
        XCTAssertNil(getQueryValue(builtUrl?.absoluteString, "optional_int"))
    }

    func testBuildURLWhenHasCorrectQueryWithoutNilValueThenGenerateURLWithQueryStrings() {
        let query = MovieQuery(page: 1, keyAccess: "a1d13so979", optionalInt: 10)
        guard let url = URL(string: "http://www.com.br") else {
            return XCTFail("Invalid URL")
        }

        let builtUrl = try? urlWithQueryAdapter.build(withUrl: url, query: query)

        XCTAssertTrue(builtUrl?.absoluteString.starts(with: url.absoluteString) ?? false)
        XCTAssertEqual("\(query.page)", getQueryValue(builtUrl?.absoluteString, "page"))
        XCTAssertEqual("\(query.keyAccess)", getQueryValue(builtUrl?.absoluteString, "key_access"))
        XCTAssertEqual("\(query.optionalInt ?? 0)", getQueryValue(builtUrl?.absoluteString, "optional_int"))
    }

    func testBuildStringURLWhenHasCorrectQueryWithoutNilValueThenGenerateURLWithQueryStrings() {
        let query = MovieQuery(page: 1, keyAccess: "a1d13so979", optionalInt: 10)
        let url = "http://www.com.br"

        let builtUrl = try? urlWithQueryAdapter.build(withUrl: url, query: query)

        XCTAssertTrue(builtUrl?.absoluteString.starts(with: url) ?? false)
        XCTAssertEqual("\(query.page)", getQueryValue(builtUrl?.absoluteString, "page"))
        XCTAssertEqual("\(query.keyAccess)", getQueryValue(builtUrl?.absoluteString, "key_access"))
        XCTAssertEqual("\(query.optionalInt ?? 0)", getQueryValue(builtUrl?.absoluteString, "optional_int"))
    }

    func testBuildStringURLWhenHasInvalidUrlThenThrowInvalidURLError() {
        let query = MovieQuery(page: 1, keyAccess: "a1d13so979", optionalInt: 10)
        let url = "http://www.çøµ.∫®"

        XCTAssertThrowsError(try urlWithQueryAdapter.build(withUrl: url, query: query)) {
            XCTAssertEqual($0 as? FrisbeeError, FrisbeeError.invalidUrl)
        }
    }

    private func getQueryValue(_ urlString: String?, _ param: String) -> String? {
        guard let urlString = urlString, let url = URLComponents(string: urlString) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }

    static var allTests = [
        ("testBuildURLWhenHasCorrectQueryWithNilValueThenGenerateURLWithQueryStrings",
         testBuildURLWhenHasCorrectQueryWithNilValueThenGenerateURLWithQueryStrings),
        ("testBuildStringURLWhenHasCorrectQueryWithNilValueThenGenerateURLWithQueryStrings",
         testBuildStringURLWhenHasCorrectQueryWithNilValueThenGenerateURLWithQueryStrings),
        ("testBuildURLWhenHasCorrectQueryWithoutNilValueThenGenerateURLWithQueryStrings",
         testBuildURLWhenHasCorrectQueryWithoutNilValueThenGenerateURLWithQueryStrings),
        ("testBuildStringURLWhenHasCorrectQueryWithoutNilValueThenGenerateURLWithQueryStrings",
         testBuildStringURLWhenHasCorrectQueryWithoutNilValueThenGenerateURLWithQueryStrings),
        ("testBuildStringURLWhenHasInvalidUrlThenThrowInvalidURLError",
         testBuildStringURLWhenHasInvalidUrlThenThrowInvalidURLError)
    ]

}
