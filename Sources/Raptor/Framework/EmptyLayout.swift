//
// EmptyLayout.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A layout that applies almost no styling.
public struct EmptyLayout: Layout {
    public var body: some Document {
        Main()
    }

    public init() {}
}
