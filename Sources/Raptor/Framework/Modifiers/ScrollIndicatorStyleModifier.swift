//
// ScrollIndicatorStyleModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Sets the visual style of the scroll indicator for this HTML element.
    /// - Parameter style: The desired scroll indicator appearance.
    /// - Returns: A modified HTML element with the specified scroll indicator style.
    func scrollIndicatorStyle(_ style: ScrollIndicatorStyle) -> some HTML {
        self.style(.custom("scrollbar-width", value: style.rawValue))
    }
}

public extension HTML {
    /// Controls the visibility of the scroll indicator for this HTML element.
    /// - Parameter visibility: Whether the scroll indicator should be shown or hidden.
    /// - Returns: A modified HTML element with the specified scroll indicator visibility.
    func scrollIndicatorVisibility(_ visibility: Visibility) -> some HTML {
        self.style(.custom("scrollbar-width", value: visibility == .hidden ? "none" : "auto"))
    }
}
