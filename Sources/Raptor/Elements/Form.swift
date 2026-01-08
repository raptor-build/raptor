//
// Form.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A form container for collecting user input
public struct Form<Content: HTML>: HTML {
    /// The behavior of the `HTML` view; forms do not render a body.
    public var body: Never { fatalError() }

    /// HTML attributes applied to the `<form>` element.
    public var attributes = CoreAttributes()

    /// The content (fields, buttons, etc.) inside the form.
    private var content: Content

    /// Label style applied to child controls (if they opt in).
    private var labelStyle: ControlLabelStyle = .top

    /// Sets the style for form labels
    /// - Parameter style: How labels should be displayed
    /// - Returns: A modified form with the specified label style
    public func labelStyle(_ style: ControlLabelStyle) -> Self {
        var copy = self
        BuildContext.set(style)
        copy.labelStyle = style
        return copy
    }

    /// Creates a new form with the specified spacing and content.
    /// - Parameters:
    ///   - spacing: The amount of horizontal space between elements. Defaults to `.medium`.
    ///   - content: A closure that returns the form's elements.
    public init(@HTMLBuilder content: () -> Content) {
        self.content = content()
        attributes.id = UUID().uuidString.truncatedHash
    }

    public func render() -> Markup {
        BuildContext.resetControlLabelStyle()

        return Tag("form") {
            content
        }
        .class("form", labelStyle.formClass)
        .attributes(attributes)
        .render()
    }
}
