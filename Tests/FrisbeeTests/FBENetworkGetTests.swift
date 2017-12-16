import XCTest
@testable import Frisbee

class FBENetworkGetTests: XCTestCase {
    private let invalidUrl = "🤷‍♂️"

    func testGetWhenURLStringIsInvalidFormatThenExecuteCompletionHandlerWithInvalidURLError() {
        var generatedResult: FBEResult!

        FBENetworkGet.get(url: invalidUrl) { result in
            generatedResult = result
        }

        XCTAssertEqual(generatedResult, FBEResult.error(FBEError.invalidUrl))
    }

    static var allTests = [
        ("testGetWhenURLStringIsInvalidFormatThenExecuteCompletionHandlerWithInvalidURLError", testGetWhenURLStringIsInvalidFormatThenExecuteCompletionHandlerWithInvalidURLError),
    ]
}
