//
// Edge.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Describes edges on an element, e.g. top or leading, along
/// with groups of edges such as "horizontal" (leading *and* trailing).
public struct Edge: OptionSet, Sendable {
    /// The internal value used to represent this edge.
    public let rawValue: Int

    /// Creates a new `Edge` instance from a raw value integer.
    /// - Parameter rawValue: The internal value for this edge.
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    /// The top edge of an element,
    public static let top = Edge(rawValue: 1 << 0)

    /// The leading edge of an element, i.e. left in left-to-right languages.
    public static let leading = Edge(rawValue: 1 << 1)

    /// The bottom edge of an element.
    public static let bottom = Edge(rawValue: 1 << 2)

    /// The trailing edge of an element, i.e. right in left-to-right languages.
    public static let trailing = Edge(rawValue: 1 << 3)

    /// The leading and trailing edges of an element.
    public static let horizontal: Edge = [.leading, .trailing]

    /// The top and bottom edges of an element.
    public static let vertical: Edge = [.top, .bottom]

    /// All edges of an element.
    public static let all: Edge = [.horizontal, .vertical]
}

/// Both the margin() and padding() modifiers work identically apart from the exact
/// name of the CSS attribute they change, so their functionality is wrapped up here
/// to avoid code duplication. This should not be called directly.
extension Edge {
    /// Adjusts the edge value (margin or padding) for a view using an adaptive amount.
    /// - Parameters:
    ///   - prefix: Specifies what we are changing, e.g. "padding"
    ///   - edges: Which edges we are changing.
    ///   - amount: The value we are changing it to.
    /// - Returns: An array of class names for the edge adjustments.
    func classes(prefix: String, amount: Int) -> [String] {
        var classes = [String]()

        if self.contains(.all) {
            classes.append("\(prefix)-\(amount)")
            return classes
        }

        if self.contains(.horizontal) {
            classes.append("\(prefix)x-\(amount)")
        } else {
            if self.contains(.leading) {
                classes.append("\(prefix)s-\(amount)")
            }

            if self.contains(.trailing) {
                classes.append("\(prefix)e-\(amount)")
            }
        }

        if self.contains(.vertical) {
            classes.append("\(prefix)y-\(amount)")
        } else {
            if self.contains(.top) {
                classes.append("\(prefix)t-\(amount)")
            }

            if self.contains(.bottom) {
                classes.append("\(prefix)b-\(amount)")
            }
        }

        return classes
    }
}

extension Edge {
    /// Generates a list of padding-related CSS `Property` values
    /// based on the specified `SpacingEdges`.
    /// - Parameters:
    ///   - length: The CSS length to apply (e.g., `"10px"`, `"1rem"`).
    ///   - combineAll: If true, `.all` maps to one shorthand `padding: <length>`.
    /// - Returns: An array of `Property` values representing the correct
    ///   padding CSS declarations.
    func paddingStyles(_ length: LengthUnit, combineAll: Bool = true) -> [Property] {
        var result: [Property] = []

        if combineAll, contains(.all) {
            result.append(.padding(length))
            return result
        }

        if contains(.top) { result.append(.paddingTop(length)) }
        if contains(.bottom) { result.append(.paddingBottom(length)) }
        if contains(.leading) { result.append(.paddingLeft(length)) }
        if contains(.trailing) { result.append(.paddingRight(length)) }

        return result
    }

    /// Generates a list of margin-related CSS `Property` values
    /// based on the specified `SpacingEdges`.
    /// - Parameters:
    ///   - length: The CSS length to apply (e.g., `"12px"`, `"2rem"`).
    ///   - combineAll: If true, `.all` maps to one shorthand `margin: <length>`.
    /// - Returns: An array of `Property` values representing the correct
    ///   margin CSS declarations.
    func marginStyles(_ length: LengthUnit, combineAll: Bool = true) -> [Property] {
        var result: [Property] = []

        // Use shorthand when possible
        if combineAll, contains(.all) {
            result.append(.margin(length))
            return result
        }

        // Individual edges
        if contains(.top) { result.append(.marginTop(length)) }
        if contains(.bottom) { result.append(.marginBottom(length)) }
        if contains(.leading) { result.append(.marginLeft(length)) }
        if contains(.trailing) { result.append(.marginRight(length)) }

        return result
    }

    /// Generates CSS custom property assignments (`--variable: value`)
    /// for the specified edges.
    /// - Parameters:
    ///   - prefix: The custom property prefix (e.g. `"--padding"`, `"--margin"`).
    ///   - value: The CSS value assigned to each variable (e.g. `"10px"`, `"1rem"`).
    /// - Returns: An array of `Property` values representing the custom CSS variables.
    func edgeSet(variablePrefix: String, value: String) -> [Property] {
        var styles = [Property]()

        if self.contains(.top) {
            styles.append(.variable("\(variablePrefix)-top", value: value))
        }
        if self.contains(.bottom) {
            styles.append(.variable("\(variablePrefix)-bottom", value: value))
        }
        if self.contains(.leading) {
            styles.append(.variable("\(variablePrefix)-left", value: value))
        }
        if self.contains(.trailing) {
            styles.append(.variable("\(variablePrefix)-right", value: value))
        }

        return styles
    }
}
