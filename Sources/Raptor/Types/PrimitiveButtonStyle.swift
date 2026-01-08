//
// ButtonStyle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the visual style of a button
public enum PrimitiveButtonStyle: String, CaseIterable {
    /// Plain button with no background or border - appears as regular text
    case plain
    /// Automatic button - like plain but with accent color and tap feedback
    case borderless
    /// Button with border and transparent background
    case bordered
    /// Button with solid background and border
    case filled
    /// Enhanced filled button with larger padding, bold font, and shadow for primary actions
    case filledProminent = "prominent"

    var cssClass: String {
        "btn-\(rawValue)"
    }
}

public extension HTML {
    /// Sets the visual style of the button
    /// - Parameter style: The button style to apply
    /// - Returns: A modified button with the specified style
    func buttonStyle(_ style: PrimitiveButtonStyle) -> some HTML {
        self.class(style.cssClass)
    }
}

public extension InlineContent {
    /// Sets the visual style of the button
    /// - Parameter style: The button style to apply
    /// - Returns: A modified button with the specified style
    func buttonStyle(_ style: PrimitiveButtonStyle) -> some InlineContent {
        self.class(style.cssClass)
    }
}
