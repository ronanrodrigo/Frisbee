import XCTest
@testable import Frisbee

final class DecoderDataAdapterTests: XCTestCase {

    func testDecodeWhenEncodableGenericIsDataThenDecodeData() throws {
        let data = Data(count: 33)

        let decodedData = try DecoderDataAdapter().decode(Data.self, from: data)

        XCTAssertEqual(decodedData!.count, data.count)
    }

    func testDecodeWhenEncodableGenericIsNilThenDecodeDataIsNil() throws {
        let decodedData = try DecoderDataAdapter().decode(Data.self, from: nil)

        XCTAssertNil(decodedData)
    }

    func testDecodeWhenNotDataEntityThenThrowsError() throws {
        let empty = Empty()
        let emptyData = try EncoderJSONAdapter().encode(empty)

        XCTAssertThrowsError(try DecoderDataAdapter().decode(Empty.self, from: emptyData))
    }

}
