import XCTest
import Frisbee

final class IntegrationNetworkPostTests: XCTestCase {

    struct Json: Decodable {
        let url: String
    }

    func testPostWhenHasValidURLThenRequestAndTransformData() {
        let url = URL(string: "https://httpbin.org/anything/testPostWhenHasValidURLThenRequestAndTransformData")!
        let longRunningExpectation = expectation(description: "RequestMoviesWithSuccess")
        let expectedUrlAtResponse = url.absoluteString
        var returnedData: Json?

        NetworkPost().post(url: url) { (result: Result<Json>) in
            returnedData = result.data
            longRunningExpectation.fulfill()
        }

        waitForExpectations(timeout: 20) { expectationError in
            XCTAssertNil(expectationError, expectationError!.localizedDescription)
            XCTAssertEqual(returnedData?.url, expectedUrlAtResponse)
        }
    }

}
