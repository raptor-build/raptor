//
// InlineContent.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// An element that exists inside a block element, such as an emphasized
/// piece of text.
public protocol InlineContent: CustomStringConvertible {
    /// The type of HTML content this element contains.
    associatedtype Body: InlineContent

    /// The content and behavior of this element.
    @InlineContentBuilder var body: Body { get }

    /// The standard set of control attributes for HTML elements.
    var attributes: CoreAttributes { get set }

    /// An optional stable identifier that belongs to the element.
    var stableID: String? { get }

    /// Converts this element and its children into HTML markup.
    /// - Returns: A string containing the HTML markup
    func render() -> Markup
}

public extension InlineContent {
    /// A collection of styles, classes, and attributes.
    var attributes: CoreAttributes {
        get { CoreAttributes() }
        set {} // swiftlint:disable:this unused_setter_value
    }

    /// The default implementation provides no identifier unless explicitly assigned.
    var stableID: String? { nil }

    /// Generates the complete HTML string representation of the element.
    func render() -> Markup {
        body.render()
    }

    /// The complete string representation of the element.
    var description: String {
        self.markupString()
    }
}

extension InlineContent {
    /// The rendering context of this element.
    var renderingContext: RenderingContext {
        guard let context = RenderingContext.current else {
            fatalError("InlineContent/renderingContext accessed outside of a rendering context.")
        }
        return context
    }

    /// The locale used while rendering this element.
    static var locale: Locale {
        RenderingContext.current?.locale ?? .automatic
    }

    /// The default status as a primitive element.
    var isPrimitive: Bool {
        Self.Body.self == Never.self
    }

    /// Checks if this element renders an empty string.
    var isEmptyContent: Bool {
        render().isEmpty
    }
}

extension InlineContent {
    /// Converts this element and its children into an HTML string with attributes.
    /// - Returns: A string containing the HTML markup
    func markupString() -> String {
        render().string
    }

    func subviews() -> InlineSubviewCollection {
        InlineSubviewCollection(self)
    }

    /// Adds an event handler to the element.
    /// - Parameters:
    ///   - name: The name of the event (e.g., "click", "mouseover")
    ///   - actions: Array of actions to execute when the event occurs
    /// - Returns: The modified `InlineElement`
    mutating func addEvent(name: String, actions: [Action]) {
        guard !actions.isEmpty else { return }
        let event = Event(name: name, actions: actions)
        attributes.events.append(event)
    }
}

public extension InlineContent {
    func modifier<M: InlineContentModifier>(_ modifier: M) -> some InlineContent {
        ModifiedInlineContent(content: self, modifier: modifier)
    }
}
