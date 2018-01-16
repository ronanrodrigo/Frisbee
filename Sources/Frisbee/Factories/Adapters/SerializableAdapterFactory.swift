final class SerializableAdapterFactory {

    static func make() -> SerializableAdapter {
        return SerializerJSONAdapter()
    }

}
