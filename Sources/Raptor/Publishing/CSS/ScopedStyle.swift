//
// ScopedStyle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Represents the fully resolved style output for a component or effect,
/// including its base class name and all of its expanded style variants.
package struct ScopedStyle: Sendable {
    /// The base CSS class name for the registered component or effect.
    let baseClass: String

    /// All variant-specific style definitions keyed by their variant descriptors.
    let variants: [ScopedStyleVariant]

    /// Computes all dynamic class names for a component or effect.
    var allClasses: [String] {
        let attachedClassNames = variants.flatMap(\.styles)
        return [baseClass] + Array(OrderedSet(attachedClassNames))
    }
}
