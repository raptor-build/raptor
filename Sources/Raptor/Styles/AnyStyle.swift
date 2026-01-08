//
// AnyStyle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A type-erased wrapper for any value conforming to the ``Style`` protocol.
struct AnyStyle: Sendable, Hashable {
    /// The underlying concrete style value.
    let wrapped: any Style

    private let hash: @Sendable (inout Hasher) -> Void
    private let equals: @Sendable (AnyStyle) -> Bool

    /// Creates a type-erased wrapper around the specified style.
    /// - Parameter style: The concrete style instance to wrap.
    init<S: Style>(_ style: S) {
        self.wrapped = style
        self.hash = { hasher in style.hash(into: &hasher) }
        self.equals = { other in
            guard let otherStyle = other.wrapped as? S else { return false }
            return otherStyle == style
        }
    }

    /// Returns a Boolean value indicating whether two style wrappers are equal.
    ///
    /// Two `AnyStyle` values are considered equal if their underlying
    /// concrete styles are of the same type and compare equal.
    static func == (lhs: AnyStyle, rhs: AnyStyle) -> Bool {
        lhs.equals(rhs)
    }

    /// Hashes the underlying style into the supplied hasher.
    /// - Parameter hasher: The hasher to use for combining the style’s value.
    func hash(into hasher: inout Hasher) {
        hash(&hasher)
    }
}
