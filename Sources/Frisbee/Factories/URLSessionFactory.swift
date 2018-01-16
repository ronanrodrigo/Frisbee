import Foundation

final class URLSessionFactory {

    static func make() -> URLSession {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)

        return session
    }

}
