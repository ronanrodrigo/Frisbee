struct FrisbeeDecodableFacotry {

    static func make() -> DecodableAdapter {
        return DecoderAdapter()
    }

}
