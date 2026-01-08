//
// Region.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A region of a `Document`.
/// - Warning: Do not conform to this type directly.
public protocol Region {
    /// The standard set of control attributes for HTML elements.
    var attributes: CoreAttributes { get set }

    /// Renders the head element as markup.
    /// - Returns: The rendered markup representation.
    func render() -> Markup
}

public extension Region {
    /// A modifier that sets the preferred color scheme for a container element.
    /// - Parameter colorScheme: The preferred color scheme to use. If `nil`, no color scheme is enforced.
    /// - Returns: A modified `Main` element with the specified color scheme.
    func preferredColorScheme(_ colorScheme: SystemColorScheme?) -> Self {
        var copy = self
        if let colorScheme {
            copy.attributes.append(dataAttributes: .init(name: "color-scheme", value: colorScheme.rawValue))
        }
        return copy
    }
}
