import XCTest
@testable import Frisbee

final class FBEResultGeneratorTests: XCTestCase {

    func testGenerateResultWhenHasDataThenGenerateSuccessResult() {
        let data = Data(count: Int(arc4random()))

        let result = FBEResultGenerator.generateResult(data: data, error: nil)

        XCTAssertEqual(result.data?.count, data.count)
    }

}
