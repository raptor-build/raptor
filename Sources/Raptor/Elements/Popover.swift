//
// Popover.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A popover element that appears near its target
struct Popover<Content: HTML>: HTML {
    /// The content and behavior of this HTML.
    var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    var attributes = CoreAttributes()

    private let htmlID: String
    private var content: Content
    private var alignment: PresentationAlignment?
    private var anchor: PopoverAnchor?

    /// Creates a new popover with the specified content.
    /// - Parameters:
    ///   - popoverID: A unique identifier for the popover.
    ///   - body: The main content of the popover.
    init(
        id popoverID: String,
        anchor: PopoverAnchor,
        @HTMLBuilder content: () -> Content
    ) {
        self.htmlID = popoverID
        self.anchor = anchor
        self.content = content()
    }

    /// Creates a new popover with the specified content.
    /// - Parameters:
    ///   - popoverID: A unique identifier for the popover.
    ///   - body: The main content of the popover.
    init(
        id popoverID: String,
        alignment: PresentationAlignment,
        @HTMLBuilder content: () -> Content
    ) {
        self.htmlID = popoverID
        self.alignment = alignment
        self.content = content()
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    func render() -> Markup {
        var attributes = attributes
        if let alignment {
            attributes.append(classes: alignment.cssClass)
        }

        if let anchor {
            attributes.append(classes: anchor.positionClass)
        }

        var isDismissible = true

        for subview in content.subviews() {
            if let id = subview.stableID,
               let context = BuildContext.current.presentations[id] {
                isDismissible = context.isDismissible
                if let background = context.background {
                    attributes.append(styles: background.style)
                }
            }
        }

        return Tag("div") {
            content
        }
        .id(htmlID)
        .attribute("popover", isDismissible ? "auto" : "manual")
        .attributes(attributes)
        .render()
    }
}

public extension HTML {
    /// Applies a popover to this element that opens when activated
    /// - Parameters:
    ///   - id: The unique identifier for the popover
    ///   - content: The popover content builder
    /// - Returns: The modified HTML with popover functionality
    @HTMLBuilder func popover(
        id: String,
        alignment: PresentationAlignment = .bottomTrailing,
        @HTMLBuilder content: @escaping () -> some HTML
    ) -> some HTML {
        Popover(id: id, alignment: alignment, content: content)
        self
    }

    /// Applies a popover to this element that opens when activated
    /// - Parameters:
    ///   - id: The unique identifier for the popover
    ///   - content: The popover content builder
    /// - Returns: The modified HTML with popover functionality
    /// - Warning: This modifier relies on a feature with limited browser support
    /// and is best used as a progressive enhancement.
    @HTMLBuilder func popover(
        id: String,
        anchor: PopoverAnchor,
        @HTMLBuilder content: @escaping () -> some HTML
    ) -> some HTML {
        Popover(id: id, anchor: anchor, content: content)
        self
    }
}

public extension InlineContent {
    /// Applies a popover to this element that opens when activated
    /// - Parameters:
    ///   - id: The unique identifier for the popover
    ///   - content: The popover content builder
    /// - Returns: The modified HTML with popover functionality
    @HTMLBuilder func popover(
        id: String,
        alignment: PresentationAlignment = .bottomTrailing,
        @HTMLBuilder content: @escaping () -> some HTML
    ) -> some HTML {
        Popover(id: id, alignment: alignment, content: content)
        self
    }

    /// Applies a popover to this element that opens when activated
    /// - Parameters:
    ///   - id: The unique identifier for the popover
    ///   - content: The popover content builder
    /// - Returns: The modified HTML with popover functionality
    /// - Warning: This modifier relies on a feature with limited browser support
    /// and is best used as a progressive enhancement.
    @HTMLBuilder func popover(
        id: String,
        anchor: PopoverAnchor,
        @HTMLBuilder content: @escaping () -> some HTML
    ) -> some HTML {
        let anchorID = UUID().uuidString.truncatedHash
        Popover(id: id, anchor: anchor, content: content)
            .style(.variable("anchor-id", value: "--\(anchorID)"))
        self.style(.custom("anchor-name", value: "--\(anchorID)"))
    }
}
