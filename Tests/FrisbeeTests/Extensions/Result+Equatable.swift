import Frisbee

extension Result: Equatable {

    public static func == (lhs: Result, rhs: Result) -> Bool {
        switch (lhs, rhs) {
        case (let Result.fail(lhsError), let Result.fail(rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }

}
