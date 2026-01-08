//
// FontStyle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public typealias FontStyle = Font.Style

/// Represents different text styles available in the system
public extension Font {
    enum Style: String, CaseIterable, Sendable {
        /// A primary heading style size (2.5rem)
        case title1 = "h1"

        /// A secondary heading style size (2rem)
        case title2 = "h2"

        /// A tertiary heading style size (1.75rem)
        case title3 = "h3"

        /// A fourth-level heading style size (1.5rem)
        case title4 = "h4"

        /// A fifth-level heading style size (1.25rem)
        case title5 = "h5"

        /// A sixth-level heading style size (1rem)
        case title6 = "h6"

        /// The default body text style size (1rem)
        case body = "p"

        /// A small variant of body text suitable for components like footers (0.9rem)
        case small

        /// A smaller variant of body text suitable for components like footers (0.8rem)
        case xSmall

        /// A very small variant of body text suitable for components like footers (0.75rem)
        case xxSmall

        /// A tiny variant of body text suitable for components like footers (0.65rem)
        case xxxSmall

        public var description: String { rawValue }

        /// The font-size utility class for this style
        var sizeClass: String? {
            switch self {
            case .title1: "fs-1"
            case .title2: "fs-2"
            case .title3: "fs-3"
            case .title4: "fs-4"
            case .title5: "fs-5"
            case .title6: "fs-6"
            case .body: nil // Default body size doesn't need a class
            case .small: "text-small"
            case .xSmall: "text-xSmall"
            case .xxSmall: "text-xxSmall"
            case .xxxSmall: "text-xxxSmall"
            }
        }

        /// A list of font styles that generate CSS classes, as opposed to HTML tags.
        static let classBasedStyles: [Style] = [
            .small, .xSmall, .xxSmall, .xxxSmall
        ]
    }
}
