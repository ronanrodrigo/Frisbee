import XCTest
import Frisbee

final class IntegrationNetworkPostTests: XCTestCase {

    struct Json: Codable {
        let content: String
        let url: String
    }

    func testPostWhenHasValidURLThenRequestAndTransformData() {
        let url = URL(string: "https://putsreq.com/RrJlwsma8cM8TjC1ipmB")!
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
            XCTAssertEqual(returnedData?.content, "content")
        }
    }

    func testPostWhenHasValidURLAndWithBodyThenRequestAndTransformData() {
        let url = URL(string: "https://putsreq.com/RrJlwsma8cM8TjC1ipmB")!
        let longRunningExpectation = expectation(description: "RequestMoviesWithSuccess")
        var returnedData: Json?
        let body = Json(content: #function, url: url.absoluteString)

        NetworkPost().post(url: url, body: body) { (result: Result<Json>) in
            returnedData = result.data
            longRunningExpectation.fulfill()
        }

        waitForExpectations(timeout: 20) { expectationError in
            XCTAssertNil(expectationError, expectationError!.localizedDescription)
            XCTAssertEqual(returnedData?.url, body.url)
            XCTAssertEqual(returnedData?.content, body.content)
        }
    }

    static var allTests = [
        ("testPostWhenHasValidURLThenRequestAndTransformData",
         testPostWhenHasValidURLThenRequestAndTransformData),
        ("testPostWhenHasValidURLAndWithBodyThenRequestAndTransformData",
         testPostWhenHasValidURLAndWithBodyThenRequestAndTransformData)
    ]

}
