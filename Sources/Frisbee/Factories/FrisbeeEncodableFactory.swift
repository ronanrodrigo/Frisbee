class FrisbeeEncodableFactory {

    static func make() -> FrisbeeEncodable {
        return FrisbeeJSONEncoder()
    }

}
