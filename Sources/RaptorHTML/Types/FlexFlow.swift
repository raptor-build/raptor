//
// FlexFlow.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Shorthand for defining both the flex direction and wrapping behavior of flex items.
public struct FlexFlow: Sendable, Hashable {
    let direction: FlexDirection
    let wrap: FlexWrap

    /// The combined CSS string for the flex-flow property.
    var css: String { "\(direction.css) \(wrap.css)" }

    /// Creates a new flex-flow value.
    /// - Parameters:
    ///   - direction: The direction in which flex items are placed.
    ///   - wrap: The wrapping behavior for flex items.
    public init(_ direction: FlexDirection, _ wrap: FlexWrap) {
        self.direction = direction
        self.wrap = wrap
    }
}
