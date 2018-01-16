import XCTest
@testable import Frisbee

final class BodyAdapterTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testBuildWithBodyWhenEncoderThrowsAnErrorThenThrows() {
        let builder = BodyAdapter(encoder: EncoderThrowErrorFakeAdapter(),
                                  serializer: FrisbeeJSONSerializableFactroy.make())

        XCTAssertThrowsError(try builder.build(withBody: Fake(fake: "")))
    }

    func testBuildWithBodyWhenSerializerThrowsAnErrorThenThrows() {
        let builder = BodyAdapter(encoder: FrisbeeEncodableFactory.make(),
                                  serializer: SerializerThrowErrorFakeAdapter())

        XCTAssertThrowsError(try builder.build(withBody: Fake(fake: "")))
    }

    static let allTests = [
        ("testBuildWithBodyWhenEncoderThrowsAnErrorThenThrows",
         testBuildWithBodyWhenEncoderThrowsAnErrorThenThrows),
        ("testBuildWithBodyWhenSerializerThrowsAnErrorThenThrows",
         testBuildWithBodyWhenSerializerThrowsAnErrorThenThrows)
    ]

}
