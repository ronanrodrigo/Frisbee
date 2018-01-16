struct BodyBuildableFactory {

    static func make() -> BodiableAdapter {
        return BodyAdapter(encoder: FrisbeeEncodableFactory.make(),
                           serializer: FrisbeeJSONSerializableFactroy.make())
    }

}
