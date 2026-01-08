//
// DefaultLayout.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// The layout you assigned to `Site`'s `layout` property.
public struct DefaultLayout: Layout {
    public var body: some Document {
        PlainDocument()
    }
}
