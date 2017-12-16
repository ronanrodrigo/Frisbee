import Foundation

public class FBENetworkGet: FBEGetable {

    public static func get(url: String, completionHandler: @escaping (FBEResult) -> Void) {
        guard let url = URL(string: url) else {
            return completionHandler(FBEResult.error(FBEError.invalidUrl))
        }
        get(url: url, completionHandler: completionHandler)
    }

    public static func get(url: URL, completionHandler: @escaping (FBEResult) -> Void) {
    }

}
