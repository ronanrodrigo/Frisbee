struct BodyAdapterFactory {

    static func make() -> BodiableAdapter {
        return BodyAdapter(encoder: EncodableAdapterFactory.make(),
                           serializer: JSONSerializableAdapterFactroy.make())
    }

}
