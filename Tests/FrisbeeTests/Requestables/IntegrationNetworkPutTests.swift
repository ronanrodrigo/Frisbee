import XCTest
import Frisbee

final class IntegrationNetworkPutTests: XCTestCase {

    struct Json: Codable {
        let name: String?
        let job: String?
    }

    struct ReqresId: Codable {
        let name: String?
        let job: String?
        let updatedAt: String?
    }

    func testPutWhenHasValidURLThenRequestAndTransformData() {
        let url = URL(string: "https://reqres.in/api/users")!
        let longRunningExpectation = expectation(description: "RequestMoviesWithSuccess")
        var returnedData: ReqresId?

        NetworkPut().put(url: url) { (result: Result<ReqresId>) in
            returnedData = result.data
            longRunningExpectation.fulfill()
        }

        waitForExpectations(timeout: 20) { expectationError in
            XCTAssertNil(expectationError, expectationError!.localizedDescription)
            XCTAssertNotNil(returnedData?.updatedAt)
        }
    }

    func testPutWhenHasValidURLAndWithBodyThenRequestAndTransformData() {
        let url = URL(string: "https://reqres.in/api/users/2")!
        let longRunningExpectation = expectation(description: "RequestMoviesWithSuccess")
        var returnedData: ReqresId?
        let body = Json(name: "morpheus", job: "zion resident")

        NetworkPut().put(url: url, body: body) { (result: Result<ReqresId>) in
            returnedData = result.data
            longRunningExpectation.fulfill()
        }

        waitForExpectations(timeout: 20) { expectationError in
            XCTAssertNil(expectationError, expectationError!.localizedDescription)
            XCTAssertEqual(returnedData?.name, body.name)
            XCTAssertEqual(returnedData?.job, body.job)
        }
    }

    static var allTests = [
        ("testPutWhenHasValidURLThenRequestAndTransformData",
         testPutWhenHasValidURLThenRequestAndTransformData),
        ("testPutWhenHasValidURLAndWithBodyThenRequestAndTransformData",
         testPutWhenHasValidURLAndWithBodyThenRequestAndTransformData)
    ]

}
