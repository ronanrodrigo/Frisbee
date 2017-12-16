import Frisbee

extension FBEResult: Equatable {

    public static func ==(lhs: FBEResult, rhs: FBEResult) -> Bool {
        switch (lhs, rhs) {
        case (let FBEResult.error(lhsError), let FBEResult.error(rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }

}
