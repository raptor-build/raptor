//
// Edge.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Describes physical edges on an element (top, leading, bottom, trailing),
/// including common groups such as `.horizontal`, `.vertical`, or `.all`.
///
/// This type is primarily used for CSS properties that target specific sides of an element,
/// such as `border`, `margin`, or `padding`.
///
/// Example:
/// ```swift
/// .border(.red, width: 1, edges: .horizontal)
/// ```
public struct Edge: OptionSet, Hashable, Equatable, Sendable {
    /// The raw integer value backing this option set.
    public let rawValue: Int

    /// Creates a new `Edge` from a raw integer value.
    /// - Parameter rawValue: The internal bitmask representing the edge.
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    /// The top edge of an element (`border-top`, `margin-top`, etc.).
    public static let top = Edge(rawValue: 1 << 0)

    /// The leading edge of an element (`border-left` in LTR layouts).
    public static let leading = Edge(rawValue: 1 << 1)

    /// The bottom edge of an element (`border-bottom`, `margin-bottom`, etc.).
    public static let bottom = Edge(rawValue: 1 << 2)

    /// The trailing edge of an element (`border-right` in LTR layouts).
    public static let trailing = Edge(rawValue: 1 << 3)

    /// The horizontal edges of an element (`leading` and `trailing`).
    public static let horizontal: Edge = [.leading, .trailing]

    /// The vertical edges of an element (`top` and `bottom`).
    public static let vertical: Edge = [.top, .bottom]

    /// All edges of an element (`top`, `leading`, `bottom`, `trailing`).
    public static let all: Edge = [.horizontal, .vertical]
}
