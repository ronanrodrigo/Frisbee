import Foundation
import Frisbee
import XCTest

class ResultTests: XCTestCase {
    private struct SomeEntity {}
    private struct SomeEquatableEntity: Equatable {
        static func == (lhs: SomeEquatableEntity,
                        rhs: SomeEquatableEntity) -> Bool {
            return true
        }
    }

    func testProperties() {
        let success = Result.success(SomeEquatableEntity())
        let fail = Result<SomeEquatableEntity>.fail(FrisbeeError.invalidEntity)

        XCTAssertEqual(success.data, success.data)
        XCTAssertEqual(success.error, success.error)
        XCTAssertNil(success.error)

        XCTAssertEqual(fail.error, fail.error)
        XCTAssertEqual(fail.data, fail.data)
        XCTAssertNil(fail.data)
    }

    func testEquality() {
        let success = Result.success(SomeEntity())
        let fail = Result<SomeEntity>.fail(FrisbeeError.invalidEntity)

        XCTAssertNotEqual(success, success)
        XCTAssertNotEqual(success, fail)
        XCTAssertNotEqual(fail, success)
        XCTAssertEqual(fail, fail)
    }

    func testEqualityOperatorWithEquatableEntity() {
        let success = Result.success(SomeEquatableEntity())
        let fail = Result<SomeEquatableEntity>.fail(FrisbeeError.invalidEntity)

        XCTAssertTrue(success == success)
        XCTAssertTrue(fail == fail)
        XCTAssertFalse(success == fail)
        XCTAssertFalse(fail == success)
    }
}
