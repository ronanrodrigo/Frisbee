import XCTest
@testable import Frisbee

final class ResultGeneratorTests: XCTestCase {

    private let someError = NSError(domain: "Some error", code: 33, userInfo: nil)
    private let fakeString = "Fake Fake"

    func testGenerateResultWhenEncoderTrhowAnerrorThenGenerateFailResult() {
        let data = try? JSONEncoder().encode(Fake(fake: fakeString))
        let resultGenerator = ResultGenerator<Fake>(decoder: DecoderThrowErrorFakeAdapter())

        let result = resultGenerator.generate(data: data, error: nil)

        XCTAssertEqual(result.error, .noData)
    }

    func testGenerateResultWhenInvalidDataThenGenerateSuccessResult() {
        let noDataError = FrisbeeError.noData
        let data = try? JSONEncoder().encode(Data())
        let resultGenerator: ResultGenerator<Fake> = ResultGeneratorFactory.make()

        let result = resultGenerator.generate(data: data, error: nil)

        XCTAssertEqual(result.error, noDataError)
    }

    func testGenerateResultWhenHasDataThenGenerateSuccessResult() {
        let data = try? JSONEncoder().encode(Fake(fake: fakeString))
        let resultGenerator: ResultGenerator<Fake> = ResultGeneratorFactory.make()

        let result = resultGenerator.generate(data: data, error: nil)

        XCTAssertEqual(result.data?.fake, fakeString)
    }

    func testGenerateResultWhenHasDataThenResultFailErrorIsNil() {
        let data = try? JSONEncoder().encode(Fake(fake: fakeString))
        let resultGenerator: ResultGenerator<Fake> = ResultGeneratorFactory.make()

        let result = resultGenerator.generate(data: data, error: nil)

        XCTAssertNil(result.error)
    }

    func testGenerateResultWhenHasNilDataThenGenerateNoDataErrorResult() {
        let noDataError = Result<Data>.fail(FrisbeeError.noData)
        let resultGenerator: ResultGenerator<Data> = ResultGeneratorFactory.make()

        let result = resultGenerator.generate(data: nil, error: nil)

        XCTAssertEqual(result, noDataError)
    }

    func testGenerateResultWhenHasNilDataThenResultSuccessDataIsNil() {
        let resultGenerator: ResultGenerator<Data> = ResultGeneratorFactory.make()

        let result = resultGenerator.generate(data: nil, error: nil)

        XCTAssertNil(result.data)
    }

    func testGenerateResultWhenHasErrorThenGenerateErrorResult() {
        let resultGenerator: ResultGenerator<Data> = ResultGeneratorFactory.make()
        let noDataError = FrisbeeError.other(localizedDescription: someError.localizedDescription)

        let result = resultGenerator.generate(data: nil, error: someError)

        XCTAssertEqual(result.error, noDataError)
    }

    func testGenerateResultWhenHasErrorThenResultSuccessDataIsNil() {
        let resultGenerator: ResultGenerator<Data> = ResultGeneratorFactory.make()

        let result = resultGenerator.generate(data: nil, error: someError)

        XCTAssertNil(result.data)
    }

    func testGenerateResultWhenHasUrlCancelledThenResultCancelledError() {
        let resultGenerator: ResultGenerator<Data> = ResultGeneratorFactory.make()
        let urlCancelled = NSError(domain: NSURLErrorDomain, code: URLError.cancelled.rawValue, userInfo: [:])

        let result = resultGenerator.generate(data: nil, error: urlCancelled)

        XCTAssertEqual(result.error, FrisbeeError.requestCancelled)
    }

    static var allTests = [
        ("testGenerateResultWhenEncoderTrhowAnerrorThenGenerateFailResult",
         testGenerateResultWhenEncoderTrhowAnerrorThenGenerateFailResult),
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
