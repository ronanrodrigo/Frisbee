import XCTest
@testable import Frisbee

#if !os(Linux)
final class URLSessionTaskAdapterTests: XCTestCase {

    func testAdapterWhenCancelThenCancelTask() {
        let task = makeTask()

        URLSessionTaskAdapter(task: task).cancel()

        XCTAssert(task.didCallCancel)
    }

    private func makeTask() -> MockDataTask {
        return MockDataTask(result: .error(MockError.noMockAvailable),
                            callback: { _, _, _  in})
    }

}
#endif
