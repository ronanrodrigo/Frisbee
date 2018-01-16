final class JSONSerializableAdapterFactroy {

    static func make() -> SerializableAdapter {
        return JSONSerializerAdapter()
    }

}
