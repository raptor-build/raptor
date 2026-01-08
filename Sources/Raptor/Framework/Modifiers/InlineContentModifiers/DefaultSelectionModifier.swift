//
// DefaultSelectionModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension InlineContent {
    /// Marks this segment as the default selected option in a segmented control.
    /// - Returns: A modified inline element flagged as the default selection.
    func defaultSelection() -> some InlineContent {
        customAttribute(.init("data-default-selection"))
    }
}
