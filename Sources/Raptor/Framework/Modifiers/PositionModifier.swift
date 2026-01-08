//
// Position.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

private struct PositionModifier: HTMLModifier {
    var position: Position?

    func body(content: Content) -> some HTML {
        var modified = content
        if let position {
            modified.attributes.append(classes: position.rawValue)
        }
        return modified
    }
}

public extension HTML {
    /// Positions an element with fixed or sticky behavior relative to the viewport.
    /// - Parameter position: The desired positioning behavior (fixed/sticky top or bottom).
    func position(_ position: Position) -> some HTML {
        modifier(PositionModifier(position: position))
    }
}

extension HTML {
    /// Positions an element with fixed or sticky behavior relative to the viewport.
    /// - Parameter position: The desired positioning behavior (fixed/sticky top or bottom).
    func position(_ position: Position?) -> some HTML {
        modifier(PositionModifier(position: position))
    }
}
