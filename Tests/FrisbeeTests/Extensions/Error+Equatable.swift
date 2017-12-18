import Frisbee

extension FrisbeeError: Equatable {
    public static func == (lhs: FrisbeeError, rhs: FrisbeeError) -> Bool {
        switch (lhs, rhs) {
        case (FrisbeeError.invalidUrl, FrisbeeError.invalidUrl),
             (FrisbeeError.noData, FrisbeeError.noData):
            return true
        case (let FrisbeeError.other(lhsError), let FrisbeeError.other(rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }
}
