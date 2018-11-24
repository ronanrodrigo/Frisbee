import Foundation
import XCTest
@testable import Frisbee

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

    func testInitFromInvalidURLErrorThenCreateFrisbeErrorInvalidURL() {
        let error: Error = FrisbeeError.invalidUrl

        let frisbeeError = FrisbeeError(error)

        XCTAssertEqual(frisbeeError, .invalidUrl)
    }

    func testInitFromUnkownErrorThenCreateFrisbeErrorOtherWithLocalizedString() {
        let error: Error = NSError(domain: "domain", code: 0)

        let frisbeeError = FrisbeeError(error)

        XCTAssertEqual(frisbeeError, .other(localizedDescription: error.localizedDescription))
    }

    func testInitWhenURLErrorCanceledThenCreateRequestCancelled() {
        let error = NSError(domain: NSURLErrorDomain, code: URLError.cancelled.rawValue, userInfo: [:])

        let frisbeeError = FrisbeeError(error)

        XCTAssertEqual(frisbeeError, .requestCancelled)
    }

    static var allTests = [
        ("testEquatableFromAllPossibleErrorsThenBeEqual",
         testEquatableFromAllPossibleErrorsThenBeEqual),
        ("testInequatableFromAllPossibleErrorsThenBeNotEqual",
         testInequatableFromAllPossibleErrorsThenBeNotEqual),
        ("testInitFromUnkownErrorThenCreateFrisbeErrorOtherWithLocalizedString",
         testInitFromUnkownErrorThenCreateFrisbeErrorOtherWithLocalizedString)
    ]

}
