import Foundation
import Frisbee
import XCTest

class FrisbeeErrorTests: XCTestCase {
    func testEquality() {
        let all = FrisbeeError.all(error: SomeError.some)

        // asserts diagonal equality
        zip(all, all).forEach { lhs, rhs in
            XCTAssertEqual(lhs, rhs)
        }
    }

    func testInequality() {
        let all = FrisbeeError.all(error: SomeError.some).enumerated()
        all.extensiveCombine(all).forEach { lhs, rhs in
            if lhs.offset == rhs.offset { //diagonal cases
                XCTAssertEqual(lhs.element, rhs.element)
            } else {
                XCTAssertNotEqual(lhs.element, rhs.element)
            }
        }
    }
}

extension FrisbeeError {
    static func all(error: Error) -> [FrisbeeError] {
        return [FrisbeeError.invalidUrl, .invalidQuery,
                .invalidEntity, .noData, .unknown,
                .other(localizedDescription: error.localizedDescription)]
    }
}
