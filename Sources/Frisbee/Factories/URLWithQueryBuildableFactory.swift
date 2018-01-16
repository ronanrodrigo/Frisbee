struct URLWithQueryBuildableFactory {

    static func make() -> URLQueriableAdapter {
        return URLQueryAdapter()
    }

}
