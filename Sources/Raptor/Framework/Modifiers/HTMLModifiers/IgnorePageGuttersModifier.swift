//
// IgnorePageGuttersModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that controls whether HTML content respects page gutters or extends full width.
private struct IgnorePageGuttersModifier: HTMLModifier {
    /// Whether the content should ignore page gutters and extend full width.
    var shouldIgnore: Bool

    /// Applies the gutter behavior to the provided content.
    /// - Parameter content: The HTML content to modify.
    /// - Returns: Modified content with appropriate width and margin styles.
    func body(content: Content) -> some HTML {
        var modified = content
        if shouldIgnore {
            modified.attributes.append(styles:
                .width(.vw(100)),
                .marginInline(.custom("calc(50% - 50vw)"))
            )
        } else {
            modified.attributes.append(classes: "container")
        }
        return modified
    }
}

public extension HTML {
    /// Determines whether this element should observe the site
    /// width or extend from one edge of the screen to the other.
    /// - Parameters:
    ///   - ignore: Whether this HTML should ignore the page gutters. Defaults to `true`.
    /// - - Returns: A modified element that either obeys or ignores the page gutters.
    func ignorePageGutters(_ ignore: Bool = true) -> some HTML {
        modifier(IgnorePageGuttersModifier(shouldIgnore: ignore))
    }
}
