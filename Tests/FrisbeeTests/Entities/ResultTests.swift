import Foundation
import Frisbee
import XCTest

class ResultTests: XCTestCase {

    func testEquatableEnumCasesWhenAssociatedValueAreEquatableThenShouldBeEqual() {
        let success = Result.success(SomeEquatableEntity(), nil)
        let fail = Result<SomeEquatableEntity>.fail(FrisbeeError.invalidEntity)

        XCTAssertEqual(success.data, success.data)
        XCTAssertEqual(success.error, success.error)
        XCTAssertNil(success.error)

        XCTAssertEqual(fail.error, fail.error)
        XCTAssertEqual(fail.data, fail.data)
        XCTAssertNil(fail.data)
    }

    func testEquatableEnumCasesWhenAssociatedValueArentEquatableThenShoudBeNotEqual() {
        let success = Result.success(SomeEntity(), nil)
        let fail = Result<SomeEntity>.fail(FrisbeeError.invalidEntity)

        XCTAssertNotEqual(success, success)
        XCTAssertNotEqual(success, fail)
        XCTAssertNotEqual(fail, success)
        XCTAssertEqual(fail, fail)
    }

    func testEqualityOperatorWhenEquatableEntityThenShoudeBeEqual() {
        let success = Result.success(SomeEquatableEntity(), nil)
        let fail = Result<SomeEquatableEntity>.fail(FrisbeeError.invalidEntity)

        XCTAssertTrue(success == success)
        XCTAssertTrue(fail == fail)
        XCTAssertFalse(success == fail)
        XCTAssertFalse(fail == success)
    }

    static var allTests = [
        ("testEquatableEnumCasesWhenAssociatedValueAreEquatableThenShouldBeEqual",
         testEquatableEnumCasesWhenAssociatedValueAreEquatableThenShouldBeEqual),
        ("testEquatableEnumCasesWhenAssociatedValueArentEquatableThenShoudBeNotEqual",
         testEquatableEnumCasesWhenAssociatedValueArentEquatableThenShoudBeNotEqual),
        ("testEqualityOperatorWhenEquatableEntityThenShoudeBeEqual",
         testEqualityOperatorWhenEquatableEntityThenShoudeBeEqual)
    ]

}
