final class SerializableAdapter {

    static func make() -> SerializableAdapter {
        return SerializerJSONAdapter()
    }

}
