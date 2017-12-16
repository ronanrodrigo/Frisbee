import Foundation

public protocol FBEGetable {
    static func get(url: URL, completionHandler: @escaping (FBEResult) -> Void)
    static func get(url: String, completionHandler: @escaping (FBEResult) -> Void)
}
