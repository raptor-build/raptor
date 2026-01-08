//
// ControlGroup.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// A container that automatically adjusts the styling for buttons it contains so
/// that they sit more neatly together.
public struct ControlGroup<Content: HTML>: HTML {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The buttons that should be displayed in this group.
    private var content: Content

    /// Creates a new `ControlGroup` from the accessibility label and an
    /// element builder that must return the buttons to use.
    /// - Parameter content: An element builder containing the contents for this group.
    public init(@HTMLBuilder content: () -> Content) {
        self.content = content()
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        Section(content)
            .attributes(attributes)
            .class("ctrl-group")
            .customAttribute(name: "role", value: "group")
            .render()
    }
}
