struct DecodableAdapterFacotry {

    static func make() -> DecodableAdapter {
        return DecoderAdapter()
    }

}
