//
// WidthMediaFeature.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A width-based CSS media feature, such as `min-width` or `max-width`.
struct WidthMediaFeature: MediaFeature, Hashable, Sendable {
    /// The media feature name (e.g. `min-width`, `max-width`).
    let name: String

    /// The width value associated with the feature.
    let value: LengthUnit

    /// The rendered media query condition.
    var condition: String {
        "\(name): \(value.css)"
    }
}
