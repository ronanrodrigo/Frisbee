import Foundation

struct SomeEntity {}
struct SomeEquatableEntity: Equatable {
    static func == (lhs: SomeEquatableEntity,
                    rhs: SomeEquatableEntity) -> Bool {
        return true
    }
}
