class FrisbeeEncodableFactory {

    static func make() -> EncodableAdapter {
        return JSONEncoderAdapter()
    }

}
