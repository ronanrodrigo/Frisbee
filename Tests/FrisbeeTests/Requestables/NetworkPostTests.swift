import XCTest
@testable import Frisbee

final class NetworkPostTests: XCTestCase {

    private let invalidUrlString = "🤷‍♂️"
    private let validUrlString = "http://www.com.br"

    #if !os(Linux)
    func testInitWithCustomUrlSessionThenKeepSameReferenceOfUrlSession() {
        let urlSession = URLSession(configuration: .default)
        let networkPost = NetworkPost(urlSession: urlSession)

        XCTAssertEqual(urlSession, networkPost.urlSession)
    }

    func testPostWhenURLStringIsInvalidFormatThenExecuteCompletionHandlerWithInvalidURLError() {
        var generatedResult: Result<Data?>!

        NetworkPost().post(url: invalidUrlString) { generatedResult = $0 }

        XCTAssertEqual(generatedResult, Result.fail(.invalidUrl))
    }

    func testPostWhenValidURLThenGenerateSuccessResult() {
        let session = MockURLSession(results: [.success(Empty.data, URLResponse())])
        let networkPost = NetworkPost(urlSession: session)
        var generatedResult: Result<Empty>!

        networkPost.post(url: validUrlString) { generatedResult = $0 }

        XCTAssertEqual(generatedResult.data, Empty())
        XCTAssertNil(generatedResult.error)
    }

    func testPostWhenValidURLWithoutBodyThenGenerateSuccessResult() {
        let session = MockURLSession(results: [.success(nil, URLResponse())])
        let networkPost = NetworkPost(urlSession: session)
        var generatedResult: Result<Empty>!

        networkPost.post(url: validUrlString) { generatedResult = $0 }

        XCTAssertNil(generatedResult.data)
        XCTAssertNil(generatedResult.error)
    }

    func testPostWhenValidURLWithBodyThenGenerateSuccessResult() {
        let session = MockURLSession(results: [.success(Empty.data, URLResponse())])
        let networkPost = NetworkPost(urlSession: session)
        let body = Empty()
        var generatedResult: Result<Empty>!

        networkPost.post(url: validUrlString, body: body) { generatedResult = $0 }

        XCTAssertEqual(generatedResult.data, Empty())
        XCTAssertNil(generatedResult.error)
    }

    func testPostWhenInvalidURLThenGenerateFailResult() {
        let session = MockURLSession(results: [])
        let networkPost = NetworkPost(urlSession: session)
        var generatedResult: Result<Empty>!

        networkPost.post(url: invalidUrlString) { generatedResult = $0 }

        XCTAssertEqual(generatedResult.error, .invalidUrl)
        XCTAssertNil(generatedResult.data)
    }

    func testPostWithBodyWhenInvalidURLThenGenerateFailResult() {
        let session = MockURLSession(results: [])
        let networkPost = NetworkPost(urlSession: session)
        let body = Empty()
        var generatedResult: Result<Empty>!

        networkPost.post(url: invalidUrlString, body: body) { generatedResult = $0 }

        XCTAssertEqual(generatedResult.error, .invalidUrl)
        XCTAssertNil(generatedResult.data)
    }

    func testPostWithBodyWhenBodyAdapterThrowAnErrorThenGenerateFailResult() {
        let session = MockURLSession(results: [])
        let networkPost = NetworkPost(urlSession: session, bodyAdapter: BodyThrowErrorFakeAdapter())
        let body = Empty()
        var generatedResult: Result<Empty>!

        networkPost.post(url: validUrlString, body: body) { generatedResult = $0 }

        XCTAssertEqual(generatedResult.error, .invalidEntity)
        XCTAssertNil(generatedResult.data)
    }

    func testPostWhenValidURLAndRequestFailsThenGenerateFailResult() {
        let session = MockURLSession(results: [.error(SomeError.some)])
        let networkPost = NetworkPost(urlSession: session)
        var generatedResult: Result<Empty>!

        networkPost.post(url: validUrlString) { generatedResult = $0 }

        XCTAssertEqual(generatedResult.error, .other(localizedDescription: SomeError.some.localizedDescription))
        XCTAssertNil(generatedResult.data)
    }
    #endif

}
