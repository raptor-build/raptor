//
// CodeBlockLineWrapping.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Controls whether long lines should break to the next line.
public enum CodeBlockLineWrapping: Equatable, Sendable {
    /// Lines that exceed the width of the code block will wrap to the next line.
    case enabled
    /// Lines that exceed the width of the code block will scroll horizontally.
    case disabled
}
