struct ResultGeneratorFactory {

    static func make<T: Decodable>() -> ResultGenerator<T> {
        return ResultGenerator(decoder: FrisbeeDecodableFacotry.make())
    }

}
