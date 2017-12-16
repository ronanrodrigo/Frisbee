import Frisbee

extension FBEError: Equatable {
    public static func ==(lhs: FBEError, rhs: FBEError) -> Bool {
        switch (lhs, rhs) {
        case (FBEError.invalidUrl, FBEError.invalidUrl),
             (FBEError.noData, FBEError.noData):
            return true
        case (let FBEError.other(lhsError), let FBEError.other(rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }
}
