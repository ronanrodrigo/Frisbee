import Frisbee

extension FBEResult: Equatable {

    public static func ==(lhs: FBEResult, rhs: FBEResult) -> Bool {
        switch (lhs, rhs) {
        case (let FBEResult.fail(lhsError), let FBEResult.fail(rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }

}
