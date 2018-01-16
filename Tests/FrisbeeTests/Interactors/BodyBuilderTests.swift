import XCTest
@testable import Frisbee

final class BodyBuilderTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testBuildWithBodyWhenEncoderThrowsAnErrorThenThrows() {
        let builder = BodyBuilder(encoder: FrisbeeThrowErrorFakeEncoder(),
                                  serializer: FrisbeeJSONSerializableFactroy.make())

        XCTAssertThrowsError(try builder.build(withBody: Fake(fake: "")))
    }

    func testBuildWithBodyWhenSerializerThrowsAnErrorThenThrows() {
        let builder = BodyBuilder(encoder: FrisbeeEncodableFactory.make(),
                                  serializer: FrisbeeThrowErrorFakeSerializer())

        XCTAssertThrowsError(try builder.build(withBody: Fake(fake: "")))
    }

    static let allTests = [
        ("testBuildWithBodyWhenEncoderThrowsAnErrorThenThrows",
         testBuildWithBodyWhenEncoderThrowsAnErrorThenThrows),
        ("testBuildWithBodyWhenSerializerThrowsAnErrorThenThrows",
         testBuildWithBodyWhenSerializerThrowsAnErrorThenThrows)
    ]

}
