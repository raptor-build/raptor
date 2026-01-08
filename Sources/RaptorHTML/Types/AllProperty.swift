//
// AllProperty.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents the special CSS `all` property, which resets all other properties to a given state.
///
/// This property affects **all** inheritable and non-inheritable properties.
public enum AllProperty: String, Sendable, Hashable {
    /// Reverts all properties within the current cascade layer.
    case revertLayer = "revert-layer"

    var css: String { rawValue }
}
