import XCTest
@testable import Frisbee

class FrisbeeTests: XCTestCase {
    func testExample() {
        XCTAssertEqual(Frisbee().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
