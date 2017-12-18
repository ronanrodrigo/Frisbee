import Foundation

struct URLRequestFactory {

    static func make(_ httpMethod: HTTPMethod, _ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue

        return request
    }

}
