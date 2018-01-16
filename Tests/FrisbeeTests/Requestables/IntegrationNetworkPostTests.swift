import XCTest
import Frisbee

final class IntegrationNetworkPostTests: XCTestCase {

    struct Json: Codable {
        let id: Int? // swiftlint:disable:this identifier_name
        let content: String?
        let url: String?
    }

    struct ReqresId: Codable {
        let id: String // swiftlint:disable:this identifier_name
    }

    func testPostWhenHasValidURLThenRequestAndTransformData() {
        let url = URL(string: "https://reqres.in/api/users")!
        let longRunningExpectation = expectation(description: "RequestMoviesWithSuccess")
        var returnedData: ReqresId?

        NetworkPost().post(url: url) { (result: Result<ReqresId>) in
            returnedData = result.data
            longRunningExpectation.fulfill()
        }

        waitForExpectations(timeout: 20) { expectationError in
            XCTAssertNil(expectationError, expectationError!.localizedDescription)
            XCTAssertNotNil(returnedData?.id)
        }
    }

    func testPostWhenHasValidURLAndWithBodyThenRequestAndTransformData() {
        let url = URL(string: "https://reqres.in/api/users")!
        let longRunningExpectation = expectation(description: "RequestMoviesWithSuccess")
        var returnedData: Json?
        let body = Json(id: 123, content: #function, url: url.absoluteString)

        NetworkPost().post(url: url, body: body) { (result: Result<Json>) in
            returnedData = result.data
            longRunningExpectation.fulfill()
        }

        waitForExpectations(timeout: 20) { expectationError in
            XCTAssertNil(expectationError, expectationError!.localizedDescription)
            XCTAssertEqual(returnedData?.id, body.id)
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
