import XCTest
@testable import Frisbee

private struct Movie: Encodable {
    let name: String
    let releaseYear: Int

    enum CodingKeys: String, CodingKey {
        case name, releaseYear = "release_year"
    }
}

final class QueryItemBuilderTests: XCTestCase {

    func testBuildWhenValidDictionaryThenReturnQueryItem() throws {
        let entity = Movie(name: "Ghostbuster", releaseYear: 1984)

        let queryItems = try QueryItemBuilder.build(withEntity: entity)

        XCTAssertEqual(queryItems.count, 2)
        XCTAssertContains(queryItems, { $0.name == "release_year" })
        XCTAssertContains(queryItems, { $0.name == "name" })
        XCTAssertContains(queryItems, { $0.value == "1984" })
        XCTAssertContains(queryItems, { $0.value == "Ghostbuster" })
    }

    static var allTests = [
        ("testBuildWhenValidDictionaryThenReturnQueryItem",
         testBuildWhenValidDictionaryThenReturnQueryItem)
    ]

}

extension XCTestCase {
    func XCTAssertContains<T>(_ array: [T], _ predicate: (T) -> Bool, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(array.contains(where: predicate))
    }
}
