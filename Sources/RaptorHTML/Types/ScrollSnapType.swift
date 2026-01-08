//
// ScrollSnapType.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Specifies how strictly snap points are enforced on a scroll container.
///
/// Example:
/// ```swift
/// .scrollSnapType(.x(.mandatory))
/// ```
public struct ScrollSnapType: Sendable, Hashable {
    let axis: Axis
    let strictness: Strictness?

    var css: String {
        if let strictness {
            "\(axis.rawValue) \(strictness.rawValue)"
        } else {
            axis.rawValue
        }
    }

    /// Snap axes.
    public enum Axis: String, Sendable, Hashable {
        case none
        case x
        case y
        case block
        case inline
        case both
    }

    /// Snap enforcement levels.
    public enum Strictness: String, Sendable, Hashable {
        case mandatory
        case proximity
    }

    /// Creates a snap type with optional strictness.
    public init(_ axis: Axis, _ strictness: Strictness? = nil) {
        self.axis = axis
        self.strictness = strictness
    }

    /// No snapping.
    public static let none = Self(.none)
}
