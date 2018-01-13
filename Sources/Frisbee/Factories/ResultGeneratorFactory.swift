struct ResultGeneratorFactory {

    static func make<Entity: Decodable>() -> ResultGenerator<Entity> {
        return ResultGenerator(decoder: FrisbeeDecodableFacotry.make())
    }

}
