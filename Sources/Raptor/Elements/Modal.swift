//
// Modal.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modal dialog presented on top of the screen
struct Modal<Content: HTML>: HTML {
    /// The content and behavior of this HTML.
    var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    var attributes = CoreAttributes()

    private let htmlID: String
    private var content: Content
    private var alignment: PresentationAlignment = .center

    /// Creates a new modal dialog with the specified content.
    /// - Parameters:
    ///   - modalID: A unique identifier for the modal.
    ///   - body: The main content of the modal.
    ///   - header: Optional header content for the modal.
    ///   - footer: Optional footer content for the modal.
    init(
        id modalID: String,
        @HTMLBuilder content: () -> Content
    ) {
        self.htmlID = modalID
        self.content = content()
    }

    /// Creates a new modal dialog with the specified content.
    /// - Parameters:
    ///   - modalID: A unique identifier for the modal.
    ///   - body: The main content of the modal.
    ///   - header: Optional header content for the modal.
    ///   - footer: Optional footer content for the modal.
    init(
        id modalID: String,
        alignment: PresentationAlignment,
        @HTMLBuilder content: () -> Content
    ) {
        self.htmlID = modalID
        self.alignment = alignment
        self.content = content()
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    func render() -> Markup {
        var attributes = attributes
        attributes.append(classes: alignment.cssClass)
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

        return Tag("dialog") {
            content
        }
        .attributes(attributes)
        .tabFocus(.focusable)
        .id(htmlID)
        .attribute("closedby", isDismissible ? "closerequest" : "none")
        .aria(.hidden, "true")
        .render()
    }
}

public extension HTML {
    /// Applies a modal to this element that opens when activated
    /// - Parameters:
    ///   - id: The unique identifier for the modal
    ///   - content: The modal content builder
    /// - Returns: The modified HTML with modal functionality
    @HTMLBuilder func modal(
        id: String,
        @HTMLBuilder content: @escaping () -> some HTML
    ) -> some HTML {
        Modal(id: id, content: content)
        self
    }
}

public extension InlineContent {
    /// Applies a modal to this element that opens when activated
    /// - Parameters:
    ///   - id: The unique identifier for the modal
    ///   - content: The modal content builder
    /// - Returns: The modified HTML with modal functionality
    @HTMLBuilder func modal(
        id: String,
        alignment: PresentationAlignment = .center,
        @HTMLBuilder content: @escaping () -> some HTML
    ) -> some HTML {
        Modal(id: id, alignment: alignment, content: content)
        self
    }
}
