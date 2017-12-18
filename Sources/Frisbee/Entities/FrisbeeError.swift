public enum FrisbeeError: Error {
    case invalidUrl
    case other(localizedDescription: String)
    case noData
}
