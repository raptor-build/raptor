//
// ScopedStyleVariant.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Holds the computed styles for a single style variant.
struct ScopedStyleVariant: Sendable {
    /// Closure that transforms the base selector into the variant-specific selector.
    let selector: Selector

    /// Any media features that scope this variant.
    var mediaFeatures: [any MediaFeature] = []

    /// Inline CSS properties for this variant.
    var styleProperties: OrderedSet<Property> = []

    /// Attached reusable class names for this variant.
    var styles: [String] = []

    /// Whether inline declarations should use `!important`.
    var important = true
}
