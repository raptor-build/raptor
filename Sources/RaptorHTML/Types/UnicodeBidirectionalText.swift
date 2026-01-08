//
// UnicodeBidi.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Specifies how bidirectional text is handled for an element.
///
/// Commonly used in combination with the `direction` property for right-to-left (RTL) languages.
public enum UnicodeBidirectionalText: String, Sendable, Hashable {
    /// Default — no additional embedding levels.
    case normal
    /// Embeds the element’s text according to the `direction` property.
    case embed
    /// Overrides the bidirectional algorithm to force a specific text direction.
    case bidiOverride = "bidi-override"
    /// Isolates the element’s text from its surrounding context.
    case isolate
    /// Creates an isolated embedding based on the element’s `direction`.
    case isolateOverride = "isolate-override"
    /// Treats the element’s content as having no inherent directionality.
    case plaintext

    var css: String { rawValue }
}
