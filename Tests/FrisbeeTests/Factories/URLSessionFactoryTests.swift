import XCTest
@testable import Frisbee

final class URLSessionFactoryTests: XCTestCase {

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
         testMakeWithoutDelegateThenReturnURLSessionWithNilDelegate)
    ]

}
