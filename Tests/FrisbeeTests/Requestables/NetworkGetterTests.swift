import XCTest
@testable import Frisbee

final class NetworkGetterTests: XCTestCase {

    private let invalidUrlString = "🤷‍♂️"
    private let validUrlString = "http://www.com.br"

    func testInitWithCustomUrlSessionThenKeepSameReferenceOfUrlSession() {
        let urlSession = URLSession(configuration: .default)
        let networkGetter = NetworkGetter(urlSession: urlSession)

        XCTAssertEqual(urlSession, networkGetter.urlSession)
    }

    func testGetWhenURLStringIsInvalidFormatThenExecuteCompletionHandlerWithInvalidURLError() {
        var generatedResult: Result<Data?>!

        NetworkGetter().get(url: invalidUrlString) { generatedResult = $0 }

        XCTAssertEqual(generatedResult, Result.fail(.invalidUrl))
    }

    func testGetWhenValidURLThenGenerateSuccessResult() {
        let session = MockURLSession(results: [.success(Empty.data, URLResponse())])
        var generatedResult: Result<Empty>!
        let getter = NetworkGetter(urlSession: session)

        getter.get(url: validUrlString) { generatedResult = $0 }

        XCTAssertEqual(generatedResult.data, Empty())
        XCTAssertNil(generatedResult.error)
    }

    func testGetWhenInvalidURLThenGenerateFailResult() {
        let session = MockURLSession(results: [])
        let getter = NetworkGetter(urlSession: session)
        var generatedResult: Result<Empty>!

        getter.get(url: invalidUrlString) { generatedResult = $0 }

        XCTAssertEqual(generatedResult.error, .invalidUrl)
        XCTAssertNil(generatedResult.data)
    }

    func testGetWithQueryWhenInvalidURLThenGenerateFailResult() {
        let session = MockURLSession(results: [])
        let getter = NetworkGetter(urlSession: session)
        let query = Empty()
        var generatedResult: Result<Empty>!

        getter.get(url: invalidUrlString, query: query) { generatedResult = $0 }

        XCTAssertEqual(generatedResult.error, .invalidUrl)
        XCTAssertNil(generatedResult.data)
    }

    func testGetWhenValidURLAndRequestFailsThenGenerateFailResult() {
        let session = MockURLSession(results: [.error(SomeError.some)])
        let getter = NetworkGetter(urlSession: session)
        var generatedResult: Result<Empty>!

        getter.get(url: validUrlString) { generatedResult = $0 }

        XCTAssertEqual(generatedResult.error, .other(localizedDescription: SomeError.some.localizedDescription))
        XCTAssertNil(generatedResult.data)
    }

    static var allTests = [
        ("testGetWhenURLStringIsInvalidFormatThenExecuteCompletionHandlerWithInvalidURLError",
         testGetWhenURLStringIsInvalidFormatThenExecuteCompletionHandlerWithInvalidURLError),
        ("testInitWithCustomUrlSessionThenKeepSameReferenceOfUrlSession",
         testInitWithCustomUrlSessionThenKeepSameReferenceOfUrlSession),
        ("testGetWhenValidURLThenGenerateSuccessResult",
         testGetWhenValidURLThenGenerateSuccessResult),
        ("testGetWhenInvalidURLThenGenerateFailResult",
         testGetWhenInvalidURLThenGenerateFailResult),
        ("testGetWithQueryWhenInvalidURLThenGenerateFailResult",
         testGetWithQueryWhenInvalidURLThenGenerateFailResult),
        ("testGetWhenValidURLAndRequestFailsThenGenerateFailResult",
         testGetWhenValidURLAndRequestFailsThenGenerateFailResult)
    ]

}
