struct BodyBuildableFactory {

    static func make() -> BodyBuildable {
        return BodyBuilder()
    }

}
