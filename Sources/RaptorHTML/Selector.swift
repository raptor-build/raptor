//
// Selector.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents different types of CSS selectors with a fluent, expressive API.
public struct Selector: CustomStringConvertible, Hashable, Equatable, Sendable {
    /// Each selector is composed of atomic parts (components) like `.class`, `[attr=val]`, etc.
    private var components: [Component]

    enum Component: Equatable, Hashable, Sendable {
        case element(String)
        case `class`(String)
        case id(String)
        case attribute(name: String, value: String)
        case booleanAttribute(String)
        case pseudoClass(String)
        case functionalPseudoClass(name: String, arguments: [Selector])
        case pseudoElement(String)
        case universal

        /// Converts the component into a valid CSS string representation.
        var description: String {
            switch self {
            case .element(let name): return name
            case .class(let name): return ".\(name)"
            case .id(let id): return "#\(id)"
            case .attribute(let name, let value): return "[\(name)=\"\(value)\"]"
            case .booleanAttribute(let name): return "[\(name)]"
            case .pseudoClass(let name): return ":\(name)"
            case .pseudoElement(let name): return "::\(name)"
            case .universal: return "*"
            case .functionalPseudoClass(let name, let arguments):
                let args = arguments.map(\.description).joined(separator: ", ")
                return ":\(name)(\(args))"
            }
        }
    }

    /// Creates a new `Selector` from one or more components.
    private init(_ components: [Component]) {
        self.components = components
    }

    /// Returns a valid CSS string representation of this selector.
    public var description: String {
        components
            .map(\.description)
            .joined()
            .replacing(/\s+/, with: " ")
    }

    /// Internal helper to join multiple selectors with a combinator.
    /// - Parameters:
    ///   - selectors: The selectors to join in order.
    ///   - combinator: The combinator string (e.g., `" "`, `">"`, `"+"`, `"~"`, `","`).
    /// - Returns: A `Selector` representing the combined selector chain.
    private static func combine(_ selectors: [Selector], with combinator: String) -> Selector {
        let joined = selectors.map(\.description).joined(separator: " \(combinator) ")
        return Selector([.element(joined)])
    }

    /// Creates a selector for an HTML element by tag name.
    /// - Parameter name: The tag name to match (e.g., `"div"`, `"button"`).
    /// - Returns: A `Selector` representing the element type.
    package static func element(_ name: String) -> Selector {
        .init([.element(name)])
    }

    /// Creates a selector for elements with the specified CSS class.
    /// - Parameter name: The class name without a leading dot.
    /// - Returns: A `Selector` representing the class selector.
    package static func `class`(_ name: String) -> Selector {
        .init([.class(name)])
    }

    /// Creates a selector for an element with the given ID.
    /// - Parameter id: The element ID without a leading `#`.
    /// - Returns: A `Selector` representing the ID selector.
    package static func id(_ id: String) -> Selector {
        .init([.id(id)])
    }

    /// Creates a selector for an attribute-value pair.
    /// - Parameters:
    ///   - name: The attribute name.
    ///   - value: The attribute value to match.
    /// - Returns: A `Selector` representing an attribute selector.
    package static func attribute(_ name: String, value: String) -> Selector {
        .init([.attribute(name: name, value: value)])
    }

    /// Creates a selector matching a boolean attribute (e.g., `[disabled]`, `[open]`, `[checked]`).
    /// - Parameter name: The name of the boolean attribute.
    /// - Returns: A `Selector` representing `[name]`.
    package static func booleanAttribute(_ name: String) -> Selector {
        .init([.booleanAttribute(name)])
    }

    /// Creates a pseudo-class selector (e.g., `:hover`, `:focus`).
    /// - Parameter name: The pseudo-class name.
    /// - Returns: A `Selector` representing a pseudo-class.
    package static func pseudoClass(_ name: String) -> Selector {
        .init([.pseudoClass(name)])
    }

    /// Creates a pseudo-element selector (e.g., `::before`, `::after`).
    /// - Parameter name: The pseudo-element name.
    /// - Returns: A `Selector` representing a pseudo-element.
    package static func pseudoElement(_ name: String) -> Selector {
        .init([.pseudoElement(name)])
    }

    /// Creates a universal selector (`*`) that matches all elements.
    /// - Returns: A universal `Selector`.
    package static func universal() -> Selector {
        .init([.universal])
    }
}

package extension Selector {
    /// Combines multiple selectors with no combinator (forming a compound selector like `p[open]`).
    /// - Parameter other: The other selector to combine with.
    /// - Returns: A `Selector` representing both selectors chained together.
    func with(_ other: Selector) -> Selector {
        Selector(components + other.components)
    }

    /// Selects elements when they are descendants (any depth) of the given parent selector.
    /// Equivalent to `parent descendant` in CSS.
    func whenDescendant(of parent: Selector) -> Selector {
        .combine([parent, self], with: " ")
    }

    /// Selects elements when they are direct children of the given parent selector.
    /// Equivalent to `parent > child` in CSS.
    func whenChild(of parent: Selector) -> Selector {
        .combine([parent, self], with: ">")
    }

    /// Selects elements when they immediately follow the given sibling.
    /// Equivalent to `previous + element` in CSS.
    func whenNextSibling(is sibling: Selector) -> Selector {
        .combine([sibling, self], with: "+")
    }

    /// Selects elements when they follow the given sibling at any distance.
    /// Equivalent to `previous ~ element` in CSS.
    func whenSibling(is sibling: Selector) -> Selector {
        .combine([sibling, self], with: "~")
    }

    /// Combines multiple selectors with a comma separator (e.g., `.a, .b, .c`).
    /// - Parameter selectors: The selectors to join.
    /// - Returns: A `Selector` representing the grouped list.
    func or(_ selectors: Selector...) -> Selector {
        .combine([self] + selectors, with: ",")
    }
}

package extension Selector {
    /// Creates a `:not()` pseudo-class selector that excludes matching elements.
    /// - Parameter selectors: Selectors to exclude.
    static func not(_ selectors: Selector...) -> Selector {
        .init([.functionalPseudoClass(name: "not", arguments: selectors)])
    }

    /// Creates an `:is()` pseudo-class selector that matches any of the given selectors.
    /// - Parameter selectors: Selectors to match.
    static func `is`(_ selectors: Selector...) -> Selector {
        .init([.functionalPseudoClass(name: "is", arguments: selectors)])
    }

    /// Creates a `:has()` pseudo-class selector that matches elements containing the given selectors.
    /// - Parameter selectors: Selectors to look for inside the element.
    static func has(_ selectors: Selector...) -> Selector {
        .init([.functionalPseudoClass(name: "has", arguments: selectors)])
    }

    /// Creates a `:where()` pseudo-class selector with zero specificity.
    /// - Parameter selectors: Selectors to match within `:where(...)`.
    static func whereClause(_ selectors: Selector...) -> Selector {
        .init([.functionalPseudoClass(name: "where", arguments: selectors)])
    }

    /// Matches elements when hovered.
    static var hover: Selector { .init([.pseudoClass("hover")]) }

    /// Matches elements that have focus.
    static var focus: Selector { .init([.pseudoClass("focus")]) }

    /// Matches elements being activated by the user.
    static var active: Selector { .init([.pseudoClass("active")]) }

    /// Matches disabled form elements.
    static var disabled: Selector { .init([.pseudoClass("disabled")]) }

    /// Inserts content before an element's actual content.
    static var before: Selector { .init([.pseudoElement("before")]) }

    /// Inserts content after an element's actual content.
    static var after: Selector { .init([.pseudoElement("after")]) }

    /// Styles the placeholder text in input fields.
    static var placeholder: Selector { .init([.pseudoElement("placeholder")]) }
}
