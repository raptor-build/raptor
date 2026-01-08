//
// HTML.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A protocol that defines the core behavior and
/// structure of `HTML` elements in Raptor.
public protocol HTML {
    /// The type of HTML content this element contains.
    associatedtype Body: HTML

    /// The content and behavior of this `HTML` element.
    @HTMLBuilder var body: Body { get }

    /// The standard set of control attributes for HTML elements.
    var attributes: CoreAttributes { get set }

    /// An optional stable identifier that belongs to the element.
    var stableID: String? { get }

    /// Converts this element and its children into HTML markup.
    /// - Returns: A string containing the HTML markup
    func render() -> Markup
}

public extension HTML {
    /// A collection of styles, classes, and attributes.
    var attributes: CoreAttributes {
        get { CoreAttributes() }
        set {} // swiftlint:disable:this unused_setter_value
    }

    /// The default implementation provides no identifier unless explicitly assigned.
    var stableID: String? { nil }

    /// Generates the complete `HTML` string representation of the element.
    func render() -> Markup {
        body.render()
    }
}

extension HTML {
    /// The rendering context of this element.
    var renderingContext: RenderingContext {
        guard let context = RenderingContext.current else {
            fatalError("HTML/renderingContext accessed outside of a rendering context.")
        }
        return context
    }

    /// The locale used while rendering this element.
    static var locale: Locale {
        RenderingContext.current?.locale ?? .automatic
    }

    /// Converts this element and its children into an HTML string with attributes.
    /// - Returns: A string containing the HTML markup
    func markupString() -> String {
        render().string
    }

    /// The default status as a primitive element.
    var isPrimitive: Bool {
        Self.Body.self == Never.self
    }

    /// Checks if this element is an empty HTML element.
    var isEmptyHTML: Bool {
        render().isEmpty
    }

    /// Whether the outermost element of this type is a `<div>`
    /// that can position its contents.
    var requiresPositioningContext: Bool {
        render().string.hasPrefix("<div") == false
    }
}

extension HTML {
    /// Adds an event handler to the element.
    /// - Parameters:
    ///   - name: The name of the event (e.g., "click", "mouseover")
    ///   - actions: Array of actions to execute when the event occurs
    /// - Returns: The modified `HTML` element
    mutating func addEvent(name: String, actions: [Action]) {
        guard !actions.isEmpty else { return }
        let event = Event(name: name, actions: actions)
        attributes.events.append(event)
    }

    /// Sets the tabindex behavior for this element.
    /// - Parameter tabFocus: The TabFocus enum value defining keyboard navigation behavior
    /// - Returns: The modified HTML element
    /// - Note: Adds appropriate HTML attribute based on TabFocus enum
    func tabFocus(_ tabFocus: TabFocus) -> some HTML {
        customAttribute(name: tabFocus.htmlName, value: tabFocus.value)
    }

    func subviews() -> SubviewCollection {
        SubviewCollection(self)
    }
}

public extension HTML {
    func modifier<M: HTMLModifier>(_ modifier: M) -> some HTML {
        ModifiedHTML(content: self, modifier: modifier)
    }
}
