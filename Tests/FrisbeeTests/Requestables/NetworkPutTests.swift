import XCTest
@testable import Frisbee

class NetworkPutTests: XCTestCase {
    
    private let invalidUrlString = "🤷‍♂️"
    private let validUrlString = "http://www.com.br"
    
    #if !os(Linux)
    func testInitWithCustomUrlSessionThenKeepSameReferenceOfUrlSession() {
        let urlSession = URLSession(configuration: .default)
        let networkPut = NetworkPut(urlSession: urlSession)
        
        XCTAssertEqual(urlSession, networkPut.urlSession)
    }
    
    func testPutWhenURLStringIsInvalidFormatThenExecuteCompletionHandlerWithInvalidURLError() {
        var generatedResult: Result<Data?>!
        
        NetworkPut().put(url: invalidUrlString) { generatedResult = $0 }
        
        XCTAssertEqual(generatedResult, Result.fail(.invalidUrl))
    }
    
    func testPutWhenValidURLThenGenerateSuccessResult() {
        let session = MockURLSession(results: [.success(Empty.data, URLResponse())])
        let networkPut = NetworkPut(urlSession: session)
        var generatedResult: Result<Empty>!
        
        networkPut.put(url: validUrlString) { generatedResult = $0 }
        
        XCTAssertEqual(generatedResult.data, Empty())
        XCTAssertNil(generatedResult.error)
    }
    
    func testPutWhenValidURLWithBodyThenGenerateSuccessResult() {
        let session = MockURLSession(results: [.success(Empty.data, URLResponse())])
        let networkPut = NetworkPut(urlSession: session)
        let body = Empty()
        var generatedResult: Result<Empty>!
        
        networkPut.put(url: validUrlString, body: body) { generatedResult = $0 }
        
        XCTAssertEqual(generatedResult.data, Empty())
        XCTAssertNil(generatedResult.error)
    }
    
    func testPutWhenInvalidURLThenGenerateFailResult() {
        let session = MockURLSession(results: [])
        let networkPut = NetworkPut(urlSession: session)
        var generatedResult: Result<Empty>!
        
        networkPut.put(url: invalidUrlString) { generatedResult = $0 }
        
        XCTAssertEqual(generatedResult.error, .invalidUrl)
        XCTAssertNil(generatedResult.data)
    }
    
    func testPutWithBodyWhenInvalidURLThenGenerateFailResult() {
        let session = MockURLSession(results: [])
        let networkPut = NetworkPut(urlSession: session)
        let body = Empty()
        var generatedResult: Result<Empty>!
        
        networkPut.put(url: invalidUrlString, body: body) { generatedResult = $0 }
        
        XCTAssertEqual(generatedResult.error, .invalidUrl)
        XCTAssertNil(generatedResult.data)
    }
    
    func testPutWithBodyWhenBodyAdapterThrowAnErrorThenGenerateFailResult() {
        let session = MockURLSession(results: [])
        let networkPut = NetworkPut(urlSession: session, bodyAdapter: BodyThrowErrorFakeAdapter())
        let body = Empty()
        var generatedResult: Result<Empty>!
        
        networkPut.put(url: validUrlString, body: body) { generatedResult = $0 }
        
        XCTAssertEqual(generatedResult.error, .invalidEntity)
        XCTAssertNil(generatedResult.data)
    }
    
    func testPutWhenValidURLAndRequestFailsThenGenerateFailResult() {
        let session = MockURLSession(results: [.error(SomeError.some)])
        let networkPut = NetworkPut(urlSession: session)
        var generatedResult: Result<Empty>!
        
        networkPut.put(url: validUrlString) { generatedResult = $0 }
        
        XCTAssertEqual(generatedResult.error, .other(localizedDescription: SomeError.some.localizedDescription))
        XCTAssertNil(generatedResult.data)
    }
    #endif
    
}
