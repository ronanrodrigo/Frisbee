import XCTest
@testable import Frisbee

struct Fake: Codable {
    let fake: String
}

final class FBEResultGeneratorTests: XCTestCase {

    private let someError = NSError(domain: "Some error", code: Int(arc4random()), userInfo: nil)
    private let fakeString = "Fake Fake"

    func testGenerateResultWhenHasDataThenGenerateSuccessResult() {
        let data = try? JSONEncoder().encode(Fake(fake: fakeString))

        let result = FBEResultGenerator<Fake>.generate(data: data, error: nil)

        XCTAssertEqual(result.data?.fake, fakeString)
    }

    func testGenerateResultWhenHasDataThenResultFailErrorIsNil() {
        let data = try? JSONEncoder().encode(Fake(fake: fakeString))

        let result = FBEResultGenerator<Fake>.generate(data: data, error: nil)

        XCTAssertNil(result.error)
    }

    func testGenerateResultWhenHasNilDataThenGenerateNoDataErrorResult() {
        let noDataError = FBEResult<Data>.fail(FBEError.noData)

        let result = FBEResultGenerator<Data>.generate(data: nil, error: nil)

        XCTAssertEqual(result, noDataError)
    }

    func testGenerateResultWhenHasNilDataThenResultSuccessDataIsNil() {
        let result = FBEResultGenerator<Data>.generate(data: nil, error: nil)

        XCTAssertNil(result.data)
    }

    func testGenerateResultWhenHasErrorThenGenerateErrorResult() {
        let noDataError = FBEError.other(localizedDescription: someError.localizedDescription)

        let result = FBEResultGenerator<Data>.generate(data: nil, error: someError)

        XCTAssertEqual(result.error, noDataError)
    }

    func testGenerateResultWhenHasErrorThenResultSuccessDataIsNil() {
        let result = FBEResultGenerator<Data>.generate(data: nil, error: someError)

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
