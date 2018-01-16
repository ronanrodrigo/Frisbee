final class ResultGeneratorFactory {

    static func make<T: Decodable>() -> ResultGenerator<T> {
        return ResultGenerator(decoder: DecodableAdapterFacotry.make())
    }

}
