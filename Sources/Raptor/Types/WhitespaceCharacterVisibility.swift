//
// WhitespaceCharacterVisibility.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Controls whether whitespace characters (spaces, tabs, newlines) are visible.
public enum WhitespaceCharacterVisibility: Equatable, Sendable {
    /// Displays visible symbols for whitespace characters.
    case visible
    /// Hides whitespace characters (default rendering).
    case hidden
}
