import XCTest
@testable import Frisbee

final class QueryStringBuilderTests: XCTestCase {

    func testBuildWhenValidDictionaryThenReturnQueryItem() {
        let queryDictionary: [String: Any] = ["name": "Ghostbuster", "release_year": 1984]

        let queryItems = QueryStringBuilder.build(query: queryDictionary)

        XCTAssertEqual(queryItems.count, queryDictionary.values.count)
        XCTAssertTrue(queryItems.contains { $0.value == "1984" })
        XCTAssertTrue(queryItems.contains { $0.value == "Ghostbuster" })
    }

    func testBuildWhenEmptyDictionaryThenReturnQueryItem() {
        let queryItems = QueryStringBuilder.build(query: [:])

        XCTAssertTrue(queryItems.isEmpty)
    }

    static var allTests = [
        ("testBuildWhenValidDictionaryThenReturnQueryItem",
         testBuildWhenValidDictionaryThenReturnQueryItem),
        ("testBuildWhenEmptyDictionaryThenReturnQueryItem",
         testBuildWhenEmptyDictionaryThenReturnQueryItem)
    ]

}
