import XCTest
@testable import Frisbee

final class ResultGeneratorTests: XCTestCase {

    private let someError = NSError(domain: "Some error", code: 33, userInfo: nil)
    private let fakeString = "Fake Fake"
    private let fakeUrl = URL(string: "www.domain.io")!

    func testGenerateResultWhenEncoderThrowAnErrorThenGenerateFailResult() {
        let data = try? JSONEncoder().encode(Fake(fake: fakeString))
        let resultGenerator = ResultGenerator<Fake>(decoder: DecoderThrowErrorFakeAdapter())
        let fakeUrlResponse = HTTPURLResponse(url: fakeUrl, statusCode: 200, httpVersion: nil, headerFields: nil)!

        let result = resultGenerator.generate(data: data, urlResponse: fakeUrlResponse, error: nil)

        XCTAssertEqual(result.error, .noData)
    }

    func testGenerateResultWhenInvalidDataThenGenerateSuccessResult() {
        let data = try? JSONEncoder().encode(Data())
        let resultGenerator: ResultGenerator<Fake> = ResultGeneratorFactory.make()
        let noContentUrlResponse = HTTPURLResponse(url: fakeUrl, statusCode: 204, httpVersion: nil, headerFields: nil)!

        let result = resultGenerator.generate(data: data, urlResponse: noContentUrlResponse, error: nil)

        XCTAssertNil(result.data)
    }

    func testGenerateResultWhenHasDataThenGenerateSuccessResult() {
        let data = try? JSONEncoder().encode(Fake(fake: fakeString))
        let resultGenerator: ResultGenerator<Fake> = ResultGeneratorFactory.make()
        let fakeUrlResponse = HTTPURLResponse(url: fakeUrl, statusCode: 201, httpVersion: nil, headerFields: nil)!

        let result = resultGenerator.generate(data: data, urlResponse: fakeUrlResponse, error: nil)

        XCTAssertEqual(result.data?.fake, fakeString)
        XCTAssertEqual(result.httpStatusCode, fakeUrlResponse.statusCode)
    }

    func testGenerateResultWhenHasDataThenResultFailErrorIsNil() {
        let data = try? JSONEncoder().encode(Fake(fake: fakeString))
        let resultGenerator: ResultGenerator<Fake> = ResultGeneratorFactory.make()
        let fakeUrlResponse = HTTPURLResponse(url: fakeUrl, statusCode: 201, httpVersion: nil, headerFields: nil)!

        let result = resultGenerator.generate(data: data, urlResponse: fakeUrlResponse, error: nil)

        XCTAssertNil(result.error)
    }

    func testGenerateResultWhenHasNoContentUrlResponseWithNilDataThenErrorIsNil() {
        let resultGenerator: ResultGenerator<Data> = ResultGeneratorFactory.make()
        let noContentUrlResponse = HTTPURLResponse(url: fakeUrl, statusCode: 204, httpVersion: nil, headerFields: nil)!

        let result = resultGenerator.generate(data: nil, urlResponse: noContentUrlResponse, error: nil)

        XCTAssertNil(result.error)
    }

    func testGenerateResultWhenHasNoContentUrlResponseWithDataThenGenerateSuccessResult() {
        let data = try? JSONEncoder().encode(Fake(fake: fakeString))
        let resultGenerator: ResultGenerator<Fake> = ResultGeneratorFactory.make()
        let noContentUrlResponse = HTTPURLResponse(url: fakeUrl, statusCode: 204, httpVersion: nil, headerFields: nil)!

        let result = resultGenerator.generate(data: data, urlResponse: noContentUrlResponse, error: nil)

        XCTAssertEqual(result.data?.fake, fakeString)
    }

    func testGenerateResultWhenHasNilDataAndNilUrlResponseThenGenerateNoDataErrorResult() {
        let noDataError = Result<Data>.fail(FrisbeeError.noData)
        let resultGenerator: ResultGenerator<Data> = ResultGeneratorFactory.make()

        let result = resultGenerator.generate(data: nil, urlResponse: nil, error: nil)

        XCTAssertEqual(result, noDataError)
    }

    func testGenerateResultWhenHasNilUrlResponseThenGenerateNoDataErrorResult() {
        let data = try? JSONEncoder().encode(Fake(fake: fakeString))
        let noDataError = Result<Data>.fail(FrisbeeError.noData)
        let resultGenerator: ResultGenerator<Data> = ResultGeneratorFactory.make()

        let result = resultGenerator.generate(data: data, urlResponse: nil, error: nil)

        XCTAssertEqual(result, noDataError)
    }

    func testGenerateResultWhenHasNilDataThenResultSuccessDataIsNil() {
        let resultGenerator: ResultGenerator<Data> = ResultGeneratorFactory.make()

        let result = resultGenerator.generate(data: nil, urlResponse: nil, error: nil)

        XCTAssertNil(result.data)
    }

    func testGenerateResultWhenHasErrorThenGenerateErrorResult() {
        let resultGenerator: ResultGenerator<Data> = ResultGeneratorFactory.make()
        let noDataError = FrisbeeError.other(localizedDescription: someError.localizedDescription)

        let result = resultGenerator.generate(data: nil, urlResponse: nil, error: someError)

        XCTAssertEqual(result.error, noDataError)
    }

    func testGenerateResultWhenHasErrorThenResultSuccessDataIsNil() {
        let resultGenerator: ResultGenerator<Data> = ResultGeneratorFactory.make()

        let result = resultGenerator.generate(data: nil, urlResponse: nil, error: someError)

        XCTAssertNil(result.data)
    }

    static var allTests = [
        ("testGenerateResultWhenEncoderThrowAnErrorThenGenerateFailResult",
         testGenerateResultWhenEncoderThrowAnErrorThenGenerateFailResult),
        ("testGenerateResultWhenHasDataThenGenerateSuccessResult",
         testGenerateResultWhenHasDataThenGenerateSuccessResult),
        ("testGenerateResultWhenHasDataThenResultFailErrorIsNil",
         testGenerateResultWhenHasDataThenResultFailErrorIsNil),
        ("testGenerateResultWhenHasNilUrlResponseThenGenerateNoDataErrorResult",
         testGenerateResultWhenHasNilUrlResponseThenGenerateNoDataErrorResult),
        ("testGenerateResultWhenHasNilDataAndNilUrlResponseThenGenerateNoDataErrorResult",
         testGenerateResultWhenHasNilDataAndNilUrlResponseThenGenerateNoDataErrorResult),
        ("testGenerateResultWhenHasNoContentUrlResponseWithNilDataThenErrorIsNil",
         testGenerateResultWhenHasNoContentUrlResponseWithNilDataThenErrorIsNil),
        ("testGenerateResultWhenHasNoContentUrlResponseWithDataThenGenerateSuccessResult",
         testGenerateResultWhenHasNoContentUrlResponseWithDataThenGenerateSuccessResult),
        ("testGenerateResultWhenHasNilDataThenResultSuccessDataIsNil",
         testGenerateResultWhenHasNilDataThenResultSuccessDataIsNil),
        ("testGenerateResultWhenHasErrorThenGenerateErrorResult",
         testGenerateResultWhenHasErrorThenGenerateErrorResult),
        ("testGenerateResultWhenHasErrorThenResultSuccessDataIsNil",
         testGenerateResultWhenHasErrorThenResultSuccessDataIsNil)
    ]

}
