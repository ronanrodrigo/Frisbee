import XCTest
@testable import Frisbee

final class URLSessionFactoryTests: XCTestCase {

    func testMakeWithDefaultConfigurationThenReturnURLSession() {
        let urlSession = URLSessionFactory.make()

        XCTAssertEqual(urlSession.configuration, URLSessionConfiguration.default)
    }

    func testMakeWithoutDelegateThenReturnURLSessionWithNilDelegate() {
        let urlSession = URLSessionFactory.make()

        XCTAssertNil(urlSession.delegate)
    }

    func testMakeWithoutDelegateQueueThenReturnURLSessionWithDefaultDelegateQueue() {
        let urlSession = URLSessionFactory.make()

        XCTAssertNotNil(urlSession.delegateQueue)
    }

    static var allTests = [
        ("testMakeWithoutDelegateQueueThenReturnURLSessionWithDefaultDelegateQueue",
         testMakeWithoutDelegateQueueThenReturnURLSessionWithDefaultDelegateQueue),
        ("testMakeWithoutDelegateThenReturnURLSessionWithNilDelegate",
         testMakeWithoutDelegateThenReturnURLSessionWithNilDelegate),
        ("testMakeWithDefaultConfigurationThenReturnURLSession",
         testMakeWithDefaultConfigurationThenReturnURLSession)
    ]

}
