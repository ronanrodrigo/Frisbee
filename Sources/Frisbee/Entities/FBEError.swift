public enum FBEError: Error {
    case invalidUrl
    case other(localizedDescription: String)
    case noData
}
