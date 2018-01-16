struct URLQueriableAdapterFactory {

    static func make() -> URLQueriableAdapter {
        return URLQueryAdapter()
    }

}
