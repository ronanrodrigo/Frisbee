import Foundation

final class ResultGeneratorFactory {

    static func make<T: Decodable>() -> ResultGenerator<T> {
        if T.self == Data.self {
            return ResultGenerator(decoder: DecodableDataAdapterFacotry.make())
        }
        return ResultGenerator(decoder: DecodableJSONAdapterFacotry.make())
    }

}
