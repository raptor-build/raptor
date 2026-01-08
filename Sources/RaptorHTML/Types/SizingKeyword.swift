//
// SizingKeyword.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents CSS sizing-related keywords used for width, height,
/// and layout properties that determine intrinsic or extrinsic size.
///
/// These keywords are defined by the **CSS Sizing Module Level 3**
/// and describe how an element’s size is calculated based on its content
/// or available space.
public enum SizingKeyword: String, Sendable, Hashable, CustomStringConvertible {
    /// The browser automatically determines the size based on layout rules.
    case auto

    /// The element’s size is clamped to fit its contents but not exceed
    /// the available space.
    case fitContent = "fit-content"

    /// The smallest possible size that can fit the content without overflow.
    case minContent = "min-content"

    /// The ideal size needed to fully display the content without wrapping.
    case maxContent = "max-content"

    /// Returns the raw CSS representation of the keyword.
    public var description: String { rawValue }

    /// The CSS string value.
    var css: String { rawValue }
}
