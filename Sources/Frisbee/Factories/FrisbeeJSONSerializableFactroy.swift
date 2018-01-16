class FrisbeeJSONSerializableFactroy {

    static func make() -> SerializableAdapter {
        return JSONSerializerAdapter()
    }

}
