//
// FormControlSpacingModifier.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Sets the vertical spacing between form controls using an explicit pixel value.
    /// - Parameter amount: The spacing, in pixels, to apply between form fields.
    /// - Returns: A modified view that applies the specified form control spacing.
    func formControlSpacing(_ amount: Int) -> Self {
        var copy = self
        copy.attributes.append(styles: .variable("form-field-spacing", value: "\(amount)px"))
        return copy
    }

    /// Sets the vertical spacing between form controls using a semantic spacing value.
    /// - Parameter amount: A semantic spacing value that maps to a scalable `em`-based spacing.
    /// - Returns: A modified view that applies the specified form control spacing.
    func formControlSpacing(_ amount: SemanticSpacing) -> Self {
        var copy = self
        copy.attributes.append(styles: .variable("form-field-spacing", value: "\(amount.multiplier)em"))
        return copy
    }
}
