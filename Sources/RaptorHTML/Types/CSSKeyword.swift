//
// CSSKeyword.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents global CSS keyword values that can be applied to most CSS properties.
///
/// Many CSS properties accept predefined *global* keywords that control
/// inheritance, reversion, or resetting of styles. Using `CSSKeyword` provides
/// a type-safe way to represent these values without resorting to raw strings.
public enum CSSKeyword: String, Sendable, Hashable, CustomStringConvertible {
    /// Resets the property to its initial (default) value as defined by the CSS specification.
    case initial

    /// Inherits the property value from the element’s parent.
    case inherit

    /// Rolls back the property to the value defined by the user agent’s default stylesheet
    /// or a user-defined style sheet, if present.
    case revert

    /// Removes any explicitly set value and causes the property to revert to its inherited
    /// or initial value, depending on whether the property is normally inherited.
    case unset

    /// The string form of the keyword, suitable for CSS serialization.
    public var description: String { rawValue }
}
