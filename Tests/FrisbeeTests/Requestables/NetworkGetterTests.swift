import XCTest
@testable import Frisbee

final class NetworkGetterTests: XCTestCase {

    private let invalidUrlString = "🤷‍♂️"
    private let validUrlString = "http://www.com.br"

    func testInitWithCustomUrlSessionThenKeepSameReferenceOfUrlSession() {
        let urlSession = URLSession(configuration: .default)
        let networkGetter = NetworkGet(urlSession: urlSession)

        XCTAssertEqual(urlSession, networkGetter.urlSession)
    }

    func testGetWhenURLStringIsInvalidFormatThenExecuteCompletionHandlerWithInvalidURLError() {
        var generatedResult: Result<Data?>!

        NetworkGet().get(url: invalidUrlString) { generatedResult = $0 }

        XCTAssertEqual(generatedResult, Result.fail(FrisbeeError.invalidUrl))
    }

    func testGetWithValidURL() {
        let session = MockURLSession(results: [.success(Empty.data, URLResponse())])
        let getter = NetworkGet(urlSession: session)

        getter.get(url: validUrlString) { (result: Result<Empty>) in
            switch result {
            case let .success(entity):
                XCTAssertEqual(entity, Empty())
            default:
                XCTFail("Expected to succeed")
            }
        }
    }

    func testGetWithInvalidURL() {
        let session = MockURLSession(results: [])
        let getter = NetworkGet(urlSession: session)

        getter.get(url: invalidUrlString) { (result: Result<Empty>) in
            switch result {
            case let .fail(error):
                XCTAssertEqual(error, FrisbeeError.invalidUrl)
            default:
                XCTFail("Expected to fail")
            }
        }
    }

    func testGetWithQueryWithInvalidURL() {
        let session = MockURLSession(results: [])
        let getter = NetworkGet(urlSession: session)
        let query = Empty()

        getter.get(url: invalidUrlString, query: query) { (result: Result<Empty>) in
            switch result {
            case let .fail(error):
                XCTAssertEqual(error, FrisbeeError.invalidUrl)
            default:
                XCTFail("Expected to fail")
            }
        }
    }

    func testGetWithValidURLFails() {
        let session = MockURLSession(results: [.error(SomeError.some)])
        let getter = NetworkGet(urlSession: session)

        getter.get(url: validUrlString) { (result: Result<Empty>) in
            switch result {
            case let .fail(error):
                XCTAssertEqual(error, FrisbeeError.other(localizedDescription: SomeError.some.localizedDescription))
            default:
                XCTFail("Expected to fail")
            }
        }
    }

    static var allTests = [
        ("testGetWhenURLStringIsInvalidFormatThenExecuteCompletionHandlerWithInvalidURLError",
         testGetWhenURLStringIsInvalidFormatThenExecuteCompletionHandlerWithInvalidURLError),
        ("testInitWithCustomUrlSessionThenKeepSameReferenceOfUrlSession",
         testInitWithCustomUrlSessionThenKeepSameReferenceOfUrlSession),
        ("testGetWithValidURL",
         testGetWithValidURL),
        ("testGetWithInvalidURL",
         testGetWithInvalidURL),
        ("testGetWithQueryWithInvalidURL",
         testGetWithQueryWithInvalidURL),
        ("testGetWithValidURLFails",
         testGetWithValidURLFails)
    ]

}
