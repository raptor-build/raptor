//
// FontFace.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// Represents a CSS @font-face rule
package struct FontFaceRule: Hashable, Equatable, Sendable {
    let family: String
    let source: URL
    let weight: String
    let style: String
    let display: String
    let ascent: String
    let descent: String
    let lineGap: String

    package init(
        family: String,
        source: URL,
        weight: String = "normal",
        style: String = "normal",
        display: String = "swap",
        ascent: String = "normal",
        descent: String = "normal",
        lineGap: String = "normal",
    ) {
        self.family = family
        self.source = source
        self.weight = weight
        self.style = style
        self.display = display
        self.ascent = ascent
        self.descent = descent
        self.lineGap = lineGap
    }

    package func render() -> String {
        """
        @font-face {
            font-family: '\(family)';
            src: url('\(source.absoluteString.lowercased())');
            font-weight: \(weight);
            font-style: \(style);
            font-display: \(display);
            ascent-override: \(ascent);
            descent-override: \(descent);
            line-gap-override: \(lineGap);
        }
        """
    }
}

extension FontFaceRule: CustomStringConvertible {
    package var description: String {
        render()
    }
}
