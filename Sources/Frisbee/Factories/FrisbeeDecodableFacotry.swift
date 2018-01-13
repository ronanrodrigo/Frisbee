struct FrisbeeDecodableFacotry {

    static func make() -> FrisbeeDecodable {
        return FrisbeeJSONDecoder()
    }

}
