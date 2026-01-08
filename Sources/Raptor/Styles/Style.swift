//
// Style.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A protocol that defines a style that can be resolved based on environment conditions.
/// Styles are used to create reusable visual treatments that can adapt based on media queries
/// and theme settings.
///
/// Example:
/// ```swift
/// struct MyCustomStyle: Style {
///     func style(content: Content, environment: EnvironmentConditions) -> Content {
///         if environment.colorScheme == .dark {
///             content.foregroundStyle(.red)
///         } else {
///             content.foregroundStyle(.blue)
///         }
///     }
/// }
/// ```
public protocol Style: Hashable, Sendable {
    typealias Content = StyleConfiguration

    /// Resolves the style for the given HTML content and environment conditions
    /// - Parameters:
    ///   - content: An HTML element to apply styles to
    ///   - environment: The current media query condition to resolve against
    /// - Returns: A modified HTML element with the appropriate styles applied
    @StyleBuilder func style(content: Content, environment: EnvironmentConditions) -> Content
}

public extension Style {
    /// The name of the CSS class this `Style` generates,
    /// derived from the type name and a framework-generated suffix.
    var className: String {
        let typeName = String(describing: type(of: self))
        let baseName = typeName.hasSuffix("Style") ? typeName : typeName + "Style"
        // We'll generate a unique suffix for each instance to create distinct CSS classes
        // whenever the same style is used with different parameters.
        let suffix = String(describing: self).truncatedHash
        return baseName.kebabCased() + "-" + suffix
    }
}
