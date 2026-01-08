//
// OffsetModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that applies a translation offset to an HTML element.
///
/// This sets CSS variables used by entry or hover effects:
/// ```css
/// --r-translate-x: 10px;
/// --r-translate-y: 5px;
/// transform: translate(var(--r-translate-x), var(--r-translate-y));
/// ```
private struct OffsetModifier: HTMLModifier {
    /// The horizontal translation in pixels.
    var x: Int

    /// The vertical translation in pixels.
    var y: Int

    func body(content: Content) -> some HTML {
        var modified = content
        modified.attributes.append(styles: Self.styles(forX: x, y: y))
        return modified
    }

    /// Generates CSS variable–based offset styles.
    /// Example output:
    ///   --r-translate-x: 10px;
    ///   --r-translate-y: -5px;
    ///   transform: translate(var(--r-translate-x), var(--r-translate-y));
    static func styles(forX x: Int, y: Int) -> [Property] {
        [
            .variable("r-translate-x", value: "\(x)px"),
            .variable("r-translate-y", value: "\(y)px"),
            .transform(.custom("translate(var(--r-translate-x), var(--r-translate-y))"))
        ]
    }
}

public extension HTML {
    /// Applies a translation offset to the element.
    /// - Parameters:
    ///   - x: The horizontal offset, in pixels.
    ///   - y: The vertical offset, in pixels.
    func offset(x: Int = 0, y: Int = 0) -> some HTML {
        modifier(OffsetModifier(x: x, y: y))
    }
}
