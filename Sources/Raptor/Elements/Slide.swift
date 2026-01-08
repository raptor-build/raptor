//
// Slide.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A slide/section within a scroll view
struct Slide<Content: HTML>: HTML {
    /// The content and behavior of this HTML.
    var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    var attributes = CoreAttributes()

    /// The content of this slide
    private var content: Content

    /// Determines how each segment should align within the scroll-snap container when scrolled.
    private var alignment: ScrollSnapAlignment

    /// Creates a new slide
    /// - Parameter content: A builder that creates the slide content
    init(_ content: Content, alignment: ScrollSnapAlignment) {
        self.content = content
        self.alignment = alignment
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    func render() -> Markup {
        var attributes = attributes
        attributes.append(styles: .custom("scroll-snap-align", value: alignment.rawValue))
        attributes.append(styles: .custom("list-style-type", value: "none"))

        return Tag("li") {
            content
        }
        .class("scroll-item")
        .attributes(attributes)
        .render()
    }
}
