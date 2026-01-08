//
// TableStripeTintModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Overrides the background color used for alternating rows or columns.
    func tableStripeTint(_ color: Color) -> some HTML {
        var copy = self
        copy.attributes.append(styles: .variable("table-stripe-bg", value: color.description))
        return copy
    }
}
