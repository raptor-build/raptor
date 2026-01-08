//
// CoreAttributes.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import OrderedCollections

/// A handful of attributes that all HTML types must support, either for
/// rendering or for publishing purposes.
public struct CoreAttributes: Equatable, Hashable, Sendable, CustomStringConvertible {
    /// A unique identifier. Can be empty.
    var id = ""

    /// ARIA attributes that add accessibility information.
    /// See https://www.w3.org/TR/html-aria/
    var aria = OrderedSet<Attribute>()

    /// CSS classes.
    var classes = OrderedSet<String>()

    /// Inline CSS styles.
    var styles = OrderedSet<Property>()

    /// Data attributes.
    var data = OrderedSet<Attribute>()

    /// JavaScript events, such as onclick.
    var events = OrderedSet<Event>()

    /// Custom attributes not covered by the above, e.g. loading="lazy"
    var customAttributes = OrderedSet<Attribute>()

    /// Whether this set of attributes is empty.
    var isEmpty: Bool { self == CoreAttributes() }

    /// All core attributes collapsed down to a single string for easy application.
    public var description: String {
        "\(idString)\(customAttributeString)\(classString)\(styleString)\(dataString)\(ariaString)\(eventString)"
    }

    /// The ID of this element, if set.
    var idString: String {
        if id.isEmpty {
            ""
        } else {
            " id=\"\(id)\""
        }
    }

    /// All aria attributes for this element collapsed down to a string.
    var ariaString: String {
        if aria.isEmpty {
            return ""
        } else {
            var output = ""

            // Arium? Look, just give me this one…
            for arium in aria {
                output += " " + arium.description
            }

            return output
        }
    }

    /// All CSS classes for this element collapsed down to a string.
    var classString: String {
        if classes.isEmpty {
            ""
        } else {
            " class=\"\(classes.joined(separator: " "))\""
        }
    }

    /// All inline CSS styles for this element collapsed down to a string.
    var styleString: String {
        if styles.isEmpty {
            return ""
        } else {
            let stringified = styles.map(\.description).joined(separator: "; ")
            return " style=\"\(stringified)\""
        }
    }

    /// All data attributes for this element collapsed down to a string.
    var dataString: String {
        if data.isEmpty {
            return ""
        } else {
            var output = ""

            for datum in data {
                output += " data-\(datum)"
            }

            return output
        }
    }

    /// All events for this element, collapsed to down to a string.
    var eventString: String {
        var result = ""

        for event in events where event.actions.isEmpty == false {
            let actions = event.actions.map { $0.compile() }.joined(separator: "; ")

            result += " \(event.name)=\"\(actions)\""
        }

        return result
    }

    /// All custom attributes for this element collapsed down to a string.
    var customAttributeString: String {
        if customAttributes.isEmpty {
            return ""
        } else {
            var output = ""

            for attribute in customAttributes {
                output += " " + attribute.description
            }

            return output
        }
    }

    /// Appends a collection of CSS classes.
    /// - Parameter classes: The CSS classes to append.
    mutating func append(classes: some Collection<String>) {
        self.classes.formUnion(classes)
    }

    /// Appends multiple CSS classes.
    /// - Parameter classes: The CSS classes to append.
    mutating func append(classes: String?...) {
        let classes = classes.compactMap(\.self)
        self.classes.formUnion(classes)
    }

    /// Appends multiple CSS classes.
    /// - Parameter classes: The CSS classes to append.
    mutating func remove(classes: String?...) {
        let classes = classes.compactMap(\.self)
        self.classes.subtract(classes)
    }

    /// Appends multiple ARIA.
    /// - Parameter aria: The aria to append.
    mutating func append(aria: Attribute?...) {
        let safeAria = aria.compactMap(\.self)
        self.aria.append(contentsOf: safeAria)
    }

    /// Returns a new set of attributes with extra CSS classes appended.
    /// - Parameter classes: The CSS classes to append.
    /// - Returns: A copy of the previous `CoreAttributes` object with
    /// the extra CSS classes applied.
    func appending(classes: some Collection<String>) -> CoreAttributes {
        var copy = self
        copy.classes.formUnion(classes)
        return copy
    }

    /// Returns a new set of attributes with extra CSS classes appended.
    /// - Parameter classes: The CSS classes to append.
    /// - Returns: A copy of the previous `CoreAttributes` object with
    /// the extra CSS classes applied.
    func appending(classes: String...) -> CoreAttributes {
        var copy = self
        copy.classes.formUnion(classes)
        return copy
    }

    /// Returns a new set of attributes with an extra aria appended.
    /// - Parameter aria: The aria to append.
    /// - Returns: A copy of the previous `CoreAttributes` object with
    /// the extra aria applied.
    func appending(aria: Attribute?) -> CoreAttributes {
        guard let aria else { return self }

        var copy = self
        copy.aria.append(aria)
        return copy
    }

    /// Appends multiple extra inline CSS styles.
    /// - Parameter classes: The inline CSS styles to append.
    mutating func append(styles: Property...) {
        let styles = styles.filter { !$0.value.isEmpty }
        self.styles.formUnion(styles)
    }

    /// Appends a data attribute.
    /// - Parameter dataAttributes: Variable number of data attributes to append.
    mutating func append(dataAttributes: Attribute...) {
        data.formUnion(dataAttributes)
    }

    /// Appends a data attribute.
    /// - Parameter dataAttributes: Variable number of data attributes to append.
    mutating func append(dataAttributes: [Attribute]) {
        data.formUnion(dataAttributes)
    }

    /// Appends multiple custom attributes.
    /// - Parameter customAttributes: Variable number of custom attributes to append,
    ///   where each attribute is an `AttributeValue` containing a name-value pair.
    mutating func append(customAttributes: Attribute...) {
        self.customAttributes.formUnion(customAttributes)
    }

    /// Appends a collection of inline CSS styles.
    /// - Parameter newStyles: A collection of `AttributeValue` objects representing
    ///   CSS style properties and their values to be appended.
    mutating func append(styles newStyles: some Collection<Property>) {
        var styles = self.styles
        let newStyles = newStyles.filter { !$0.value.isEmpty }
        styles.formUnion(newStyles)
        self.styles = styles
    }

    /// Removes all attributes.
    mutating func clear() {
        self = CoreAttributes()
    }

    /// Merges another set of `CoreAttributes` into this instance
    /// - Parameter other: The `CoreAttributes` to merge into this instance
    /// - Returns: A new `CoreAttributes` instance with the combined attributes
    func merging(_ other: CoreAttributes) -> CoreAttributes {
        var result = self

        if !other.id.isEmpty {
            result.id = other.id
        }

        result.aria.formUnion(other.aria)
        result.classes.formUnion(other.classes)
        result.styles.formUnion(other.styles)
        result.data.formUnion(other.data)
        result.events.formUnion(other.events)
        result.customAttributes.formUnion(other.customAttributes)

        return result
    }

    /// Merges another set of `CoreAttributes` into this instance in place
    /// - Parameter other: The `CoreAttributes` to merge into this instance
    mutating func merge(_ other: CoreAttributes) {
        if !other.id.isEmpty {
            id = other.id
        }

        aria.formUnion(other.aria)
        classes.formUnion(other.classes)
        styles.formUnion(other.styles)
        data.formUnion(other.data)
        events.formUnion(other.events)
        customAttributes.formUnion(other.customAttributes)
    }
}
