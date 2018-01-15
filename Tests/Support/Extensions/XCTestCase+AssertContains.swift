import XCTest

extension XCTestCase {
    func XCTAssertContains<T>(_ array: [T], _ predicate: (T) -> Bool, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(array.contains(where: predicate))
    }
}
