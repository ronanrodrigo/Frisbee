import XCTest
@testable import Frisbee

final class IntegrationNetworkGetTests: XCTestCase {

    private let url = "https://gist.githubusercontent.com/ronanrodrigo" +
    "/fbb32cee20e43f0f9972c9a3230ef93d/raw/2cb87fd40e65fadb25fcc30f643d385bccdb5f7c/movie.json"

    struct Movie: Decodable {
        let name: String
    }

    struct MovieQuery: Encodable {
        let page: Int
    }

    func testGetWhenHasValidURLWithValidEntityThenRequestAndTransformData() {
        let longRunningExpectation = expectation(description: "RequestMoviesWithSuccess")
        let expectedMovieName = "Ghostbusters"
        var returnedData: Movie?

        NetworkGet().get(url: url) { (result: Result<Movie>) in
            returnedData = result.data
            longRunningExpectation.fulfill()
        }

        waitForExpectations(timeout: 20) { expectationError in
            XCTAssertNil(expectationError, expectationError!.localizedDescription)
            XCTAssertEqual(returnedData?.name, expectedMovieName)
        }
    }

    func testGetWhenHasQueryParamentersAndValidURLWithValidEntityThenRequestAndTransformData() {
        let longRunningExpectation = expectation(description: "RequestMoviesWithSuccess")
        let expectedMovieName = "Ghostbusters"
        var returnedData: Movie?
        let query = MovieQuery(page: 10)

        NetworkGet().get(url: url, query: query) { (result: Result<Movie>) in
            returnedData = result.data
            longRunningExpectation.fulfill()
        }

        waitForExpectations(timeout: 20) { expectationError in
            XCTAssertNil(expectationError, expectationError!.localizedDescription)
            XCTAssertEqual(returnedData?.name, expectedMovieName)
        }
    }

    func testGetURLWhenHasValidURLWithValidEntityThenRequestAndTransformData() {
        let expectation = self.expectation(description: "RequestMoviesWithSuccess")
        let expectedMovieName = "Ghostbusters"
        var returnedData: Movie?

        guard let url = URL(string: self.url) else {
            return XCTFail("Could not create URL")
        }

        NetworkGet().get(url: url) { (result: Result<Movie>) in
            returnedData = result.data
            expectation.fulfill()
        }

        waitForExpectations(timeout: 20) { expectationError in
            XCTAssertNil(expectationError, expectationError!.localizedDescription)
            XCTAssertEqual(returnedData?.name, expectedMovieName)
        }
    }

    func testGetURLWhenHasQueryParametersAndValidURLWithValidEntityThenRequestAndTransformData() {
        let expectation = self.expectation(description: "RequestMoviesWithSuccess")
        let expectedMovieName = "Ghostbusters"
        var returnedData: Movie?
        let query = MovieQuery(page: 10)

        guard let url = URL(string: self.url) else {
            return XCTFail("Could not create URL")
        }

        NetworkGet().get(url: url, query: query) { (result: Result<Movie>) in
            returnedData = result.data
            expectation.fulfill()
        }

        waitForExpectations(timeout: 20) { expectationError in
            XCTAssertNil(expectationError, expectationError!.localizedDescription)
            XCTAssertEqual(returnedData?.name, expectedMovieName)
        }
    }

    static var allTests = [
        ("testGetWhenHasValidURLWithValidEntityThenRequestAndTransformData",
         testGetWhenHasValidURLWithValidEntityThenRequestAndTransformData),
        ("testGetWhenHasQueryParamentersAndValidURLWithValidEntityThenRequestAndTransformData",
         testGetWhenHasQueryParamentersAndValidURLWithValidEntityThenRequestAndTransformData),
        ("testGetURLWhenHasValidURLWithValidEntityThenRequestAndTransformData",
         testGetURLWhenHasValidURLWithValidEntityThenRequestAndTransformData),
        ("testGetURLWhenHasQueryParametersAndValidURLWithValidEntityThenRequestAndTransformData",
         testGetURLWhenHasQueryParametersAndValidURLWithValidEntityThenRequestAndTransformData)
    ]
}
