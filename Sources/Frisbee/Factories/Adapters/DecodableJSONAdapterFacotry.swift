final class DecodableJSONAdapterFacotry {

    static func make() -> DecodableAdapter {
        return DecoderJSONAdapter()
    }

}
