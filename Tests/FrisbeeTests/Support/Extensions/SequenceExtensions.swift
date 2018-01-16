import Foundation

extension Sequence {
    /// Returns the [Cartesian product](https://en.wikipedia.org/wiki/Cartesian_product) of `self`
    /// with a given sequence `x`
    /// ([0,1], [a,b,c]) -> [(0,a), (0,b), (0,c), (1,a), (1,b), (1,c)]
    /// - Parameter x: The other sequence to be combined
    func extensiveCombine<X: Sequence>(_ other: X) -> [(Self.Iterator.Element, X.Iterator.Element)] {
        return self.map { one in other.map { (one, $0) } }
            .flatMap { $0 }
    }
}
