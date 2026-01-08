//
// OpacityModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

enum OpacityType {
    case double(Double)
    case percent(Percentage)
}

/// A modifier that applies opacity styling to HTML elements.
struct OpacityModifier: HTMLModifier {
    /// The opacity value to apply.
    var opacity: OpacityType

    func body(content: Content) -> some HTML {
        var modified = content
        let styles = Self.styles(for: opacity)
        modified.attributes.append(styles: styles)
        return modified
    }

    /// Generates CSS variable–based opacity styles for the specified opacity value.
    /// Example output:
    ///   --r-opacity: 0.5;
    ///   opacity: var(--r-opacity);
    static func styles(for opacity: OpacityType) -> [Property] {
        var value: String

        switch opacity {
        case .double(let double):
            value = String(format: "%.3f", double)
        case .percent(let percentage):
            value = String(format: "%.3f", percentage.value / 100.0)
        }

        return [
            .variable("r-opacity", value: value),
            .custom("opacity", value: "var(--r-opacity)")
        ]
    }
}

public extension HTML {
    /// Adjusts the opacity of an element.
    /// - Parameter value: A value between 0% (fully transparent) and 100% (fully opaque).
    func opacity(_ value: Percentage) -> some HTML {
        modifier(OpacityModifier(opacity: .percent(value)))
    }

    /// Adjusts the opacity of an element.
    /// - Parameter value: A value between 0 (fully transparent) and 1.0 (fully opaque).
    func opacity(_ value: Double) -> some HTML {
        modifier(OpacityModifier(opacity: .double(value)))
    }
}
