//
// ZStack.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Creates a container that stacks its children along the z-axis (depth),
/// with each subsequent child appearing in front of the previous one.
public struct ZStack<Content: HTML>: HTML {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The alignment point for positioning elements within the stack.
    private var alignment: Alignment

    /// The child elements to be stacked.
    private var content: Content

    /// Creates a new `ZStack` with the specified alignment and content.
    /// - Parameters:
    ///   - alignment: The point within the stack where elements should be aligned. Defaults `.center`.
    ///   - items: A closure that returns the elements to be stacked.
    public init(
        alignment: Alignment = .center,
        @HTMLBuilder content: () -> Content
    ) {
        self.content = content()
        self.alignment = alignment
    }

    public func render() -> Markup {
        var attributes = attributes
        attributes.append(styles: .display(.grid))

        let contentHTML = content
            .subviews()
            .enumerated()
            .map { index, subview in
                addAttributesToChild(subview, at: index).markupString()
            }.joined()

        return Markup("<div\(attributes)>\(contentHTML)</div>")
    }

    private func addAttributesToChild(_ child: some HTML, at index: Int) -> some HTML {
        var elementAttributes = CoreAttributes()
        elementAttributes.append(styles: [
            .position(.relative),
            .gridArea(.lines(rowStart: 1, columnStart: 1)),
            .zIndex(index)
        ])

        elementAttributes.append(styles: alignment.itemAlignmentRules)
        return Section(child).attributes(elementAttributes)
    }
}
