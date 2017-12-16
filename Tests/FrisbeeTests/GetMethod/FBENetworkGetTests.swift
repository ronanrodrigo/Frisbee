import XCTest
@testable import Frisbee

class FBENetworkGetTests: XCTestCase {
    private let invalidUrl = "🤷‍♂️"
    private let validUrl = "http://www.com.br"

    func testGetWhenURLStringIsInvalidFormatThenExecuteCompletionHandlerWithInvalidURLError() {
        var generatedResult: FBEResult!

        FBENetworkGet.get(url: invalidUrl) { generatedResult = $0 }

        XCTAssertEqual(generatedResult, FBEResult.error(FBEError.invalidUrl))
    }

    static var allTests = [
        ("testGetWhenURLStringIsInvalidFormatThenExecuteCompletionHandlerWithInvalidURLError",
         testGetWhenURLStringIsInvalidFormatThenExecuteCompletionHandlerWithInvalidURLError),
    ]
}
