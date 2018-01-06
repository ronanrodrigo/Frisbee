import XCTest
@testable import Frisbee

struct Fake: Codable { let fake: String }

final class ResultGeneratorTests: XCTestCase {

    private let someError = NSError(domain: "Some error", code: 33, userInfo: nil)
    private let fakeString = "Fake Fake"

    func testGenerateResultWhenInvalidDataThenGenerateSuccessResult() {
        let noDataError = FrisbeeError.noData
        let data = try? JSONEncoder().encode(Data())

        let result = ResultGenerator<Fake>.generate(data: data, error: nil)

        XCTAssertEqual(result.error, noDataError)
    }

    func testGenerateResultWhenHasDataThenGenerateSuccessResult() {
        let data = try? JSONEncoder().encode(Fake(fake: fakeString))

        let result = ResultGenerator<Fake>.generate(data: data, error: nil)

        XCTAssertEqual(result.data?.fake, fakeString)
    }

    func testGenerateResultWhenHasDataThenResultFailErrorIsNil() {
        let data = try? JSONEncoder().encode(Fake(fake: fakeString))

        let result = ResultGenerator<Fake>.generate(data: data, error: nil)

        XCTAssertNil(result.error)
    }

    func testGenerateResultWhenHasNilDataThenGenerateNoDataErrorResult() {
        let noDataError = Result<Data>.fail(FrisbeeError.noData)

        let result = ResultGenerator<Data>.generate(data: nil, error: nil)

        XCTAssertEqual(result, noDataError)
    }

    func testGenerateResultWhenHasNilDataThenResultSuccessDataIsNil() {
        let result = ResultGenerator<Data>.generate(data: nil, error: nil)

        XCTAssertNil(result.data)
    }

    func testGenerateResultWhenHasErrorThenGenerateErrorResult() {
        let noDataError = FrisbeeError.other(localizedDescription: someError.localizedDescription)

        let result = ResultGenerator<Data>.generate(data: nil, error: someError)

        XCTAssertEqual(result.error, noDataError)
    }

    func testGenerateResultWhenHasErrorThenResultSuccessDataIsNil() {
        let result = ResultGenerator<Data>.generate(data: nil, error: someError)

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
