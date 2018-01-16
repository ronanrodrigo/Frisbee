struct BodyBuildableFactory {

    static func make() -> BodyBuildable {
        return BodyBuilder(encoder: FrisbeeEncodableFactory.make(),
                           serializer: FrisbeeJSONSerializableFactroy.make())
    }

}
