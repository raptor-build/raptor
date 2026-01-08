//
// BorderImageSlice.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how the border image is sliced.
public struct BorderImageSlice: Sendable, CustomStringConvertible {
    var value: String

    init(_ value: String) {
        self.value = value
    }

    public var description: String { value }
    var css: String { description }
}
