import XCTest
@testable import Frisbee

final class FBEResultGeneratorTests: XCTestCase {

    private let someError = NSError(domain: "Some error", code: Int(arc4random()), userInfo:nil)

    func testGenerateResultWhenHasDataThenGenerateSuccessResult() {
        let data = Data(count: Int(arc4random()))

        let result = FBEResultGenerator.generate(data: data, error: nil)

        XCTAssertEqual(result.data?.count, data.count)
    }

    func testGenerateResultWhenHasDataThenResultFailErrorIsNil() {
        let data = Data(count: Int(arc4random()))

        let result = FBEResultGenerator.generate(data: data, error: nil)

        XCTAssertNil(result.error)
    }

    func testGenerateResultWhenHasNilDataThenGenerateNoDataErrorResult() {
        let noDataError = FBEResult.fail(FBEError.noData)

        let result = FBEResultGenerator.generate(data: nil, error: nil)

        XCTAssertEqual(result, noDataError)
    }

    func testGenerateResultWhenHasNilDataThenResultSuccessDataIsNil() {
        let result = FBEResultGenerator.generate(data: nil, error: nil)

        XCTAssertNil(result.data)
    }

    func testGenerateResultWhenHasErrorThenGenerateErrorResult() {
        let noDataError = FBEError.other(localizedDescription: someError.localizedDescription)

        let result = FBEResultGenerator.generate(data: nil, error: someError)

        XCTAssertEqual(result.error, noDataError)
    }

    func testGenerateResultWhenHasErrorThenResultSuccessDataIsNil() {
        let result = FBEResultGenerator.generate(data: nil, error: someError)

        XCTAssertNil(result.data)
    }

    static var allTests = [
        ("testGenerateResultWhenHasDataThenGenerateSuccessResult",
         testGenerateResultWhenHasDataThenGenerateSuccessResult),
        ("testGenerateResultWhenHasDataThenResultFailErrorIsNil",
         testGenerateResultWhenHasDataThenResultFailErrorIsNil),
        ("testGenerateResultWhenHasNilDataThenGenerateNoDataErrorResult",
         testGenerateResultWhenHasNilDataThenGenerateNoDataErrorResult),
        ("testGenerateResultWhenHasNilDataThenResultSuccessDataIsNil",
         testGenerateResultWhenHasNilDataThenResultSuccessDataIsNil),
        ("testGenerateResultWhenHasErrorThenGenerateErrorResult",
         testGenerateResultWhenHasErrorThenGenerateErrorResult),
        ("testGenerateResultWhenHasErrorThenResultSuccessDataIsNil",
         testGenerateResultWhenHasErrorThenResultSuccessDataIsNil)
    ]

}
