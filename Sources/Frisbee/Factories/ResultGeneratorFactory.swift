import Foundation

final class ResultGeneratorFactory {

    static func make<T: Decodable>() -> ResultGenerator<T> {
        return ResultGenerator(decoder: DecodableAdapterFactory.make(T.self))
    }

}
