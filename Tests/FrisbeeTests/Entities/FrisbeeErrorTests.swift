import Foundation
import Frisbee
import XCTest

class FrisbeeErrorTests: XCTestCase {

    func testEquatableFromAllPossibleErrorsThenBeEqual() {
        let all = FrisbeeError.all(error: SomeError.some)

        zip(all, all).forEach { lhs, rhs in
            XCTAssertEqual(lhs, rhs)
        }
    }

    func testInequatableFromAllPossibleErrorsThenBeNotEqual() {
        let all = FrisbeeError.all(error: SomeError.some).enumerated()

        all.extensiveCombine(all).forEach { lhs, rhs in
            if lhs.offset == rhs.offset { //diagonal cases
                XCTAssertEqual(lhs.element, rhs.element)
            } else {
                XCTAssertNotEqual(lhs.element, rhs.element)
            }
        }
    }

    static var allTests = [
        ("testEquatableFromAllPossibleErrorsThenBeEqual",
         testEquatableFromAllPossibleErrorsThenBeEqual),
        ("testInequatableFromAllPossibleErrorsThenBeNotEqual",
         testInequatableFromAllPossibleErrorsThenBeNotEqual)
    ]

}
