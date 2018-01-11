import XCTest
@testable import Frisbee

final class URLRequestFactoryTests: XCTestCase {

    func testMakeWhenGetMethodThenReturnAnURLRequestWithGetVerb() {
        let request = URLRequestFactory.make(.GET, URL(string: "http://www.com.br")!)

        XCTAssertEqual(request.httpMethod, HTTPMethod.GET.rawValue)
    }

    func testMakeWithURLThenReturnAnURLRequestWithCorrectURL() {
        let url = URL(string: "http://www.com.br")!

        let request = URLRequestFactory.make(.GET, url)

        XCTAssertEqual(request.url?.absoluteString, url.absoluteString)
    }

    func testMakeWhenPostMethodThenReturnAnURLRequestWithPostVerb() {
        let request = URLRequestFactory.make(.POST, URL(string: "http://www.com.br")!)

        XCTAssertEqual(request.httpMethod, HTTPMethod.POST.rawValue)
    }

    static var allTests = [
        ("testMakeWhenGetMethodThenReturnAnURLRequestWithGetVerb",
         testMakeWhenGetMethodThenReturnAnURLRequestWithGetVerb),
        ("testMakeWithURLThenReturnAnURLRequestWithCorrectURL",
         testMakeWithURLThenReturnAnURLRequestWithCorrectURL),
        ("testMakeWhenPostMethodThenReturnAnURLRequestWithPostVerb",
         testMakeWhenPostMethodThenReturnAnURLRequestWithPostVerb)
    ]

}
