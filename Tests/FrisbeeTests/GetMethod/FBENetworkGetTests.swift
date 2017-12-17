import XCTest
@testable import Frisbee

final class MoviesControllerTests: XCTestCase {

    private let invalidUrl = "🤷‍♂️"
    private let validUrl = "http://www.com.br"

    func testGetWhenURLStringIsInvalidFormatThenExecuteCompletionHandlerWithInvalidURLError() {
        var generatedResult: FBEResult<Data?>!

        FBENetworkGet().get(url: invalidUrl) { generatedResult = $0 }

        XCTAssertEqual(generatedResult, FBEResult.fail(FBEError.invalidUrl))
    }

    static var allTests = [
        ("testGetWhenURLStringIsInvalidFormatThenExecuteCompletionHandlerWithInvalidURLError",
         testGetWhenURLStringIsInvalidFormatThenExecuteCompletionHandlerWithInvalidURLError)
    ]

}
