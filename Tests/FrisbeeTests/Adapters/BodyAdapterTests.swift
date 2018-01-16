import XCTest
@testable import Frisbee

final class BodyAdapterTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testBuildWithBodyWhenEncoderThrowsAnErrorThenThrows() {
        let adapter = BodyAdapter(encoder: EncoderThrowErrorFakeAdapter(),
                                  serializer: SerializableAdapterFactory.make())

        XCTAssertThrowsError(try adapter.build(withBody: Fake(fake: "")))
    }

    func testBuildWithBodyWhenSerializerThrowsAnErrorThenThrows() {
        let adapter = BodyAdapter(encoder: EncodableAdapterFactory.make(),
                                  serializer: SerializerThrowErrorFakeAdapter())

        XCTAssertThrowsError(try adapter.build(withBody: Fake(fake: "")))
    }

    static let allTests = [
        ("testBuildWithBodyWhenEncoderThrowsAnErrorThenThrows",
         testBuildWithBodyWhenEncoderThrowsAnErrorThenThrows),
        ("testBuildWithBodyWhenSerializerThrowsAnErrorThenThrows",
         testBuildWithBodyWhenSerializerThrowsAnErrorThenThrows)
    ]

}
