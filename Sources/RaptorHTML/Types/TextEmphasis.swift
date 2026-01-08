//
// TextEmphasis.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents emphasis marks applied to text.
///
/// Example:
/// ```swift
/// .textEmphasis(.init(style: .filled(.circle), color: .red))
/// ```
public struct TextEmphasis: Sendable, Hashable {
    let style: TextEmphasisStyle
    let color: Color?

    var css: String {
        if let color {
            "\(style.css) \(color.css)"
        } else {
            style.css
        }
    }

    public init(style: TextEmphasisStyle, color: Color? = nil) {
        self.style = style
        self.color = color
    }
}
