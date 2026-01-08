//
// ThemedSite.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public struct ThemeConfiguration: Sendable {
    /// Represents a set of semantic font roles used throughout the theme.
    public struct FontStyle: OptionSet, Sendable {
        public let rawValue: Int

        /// Creates a new font style set with the given raw value.
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        /// Standard body text.
        public static let body = FontStyle(rawValue: 1 << 0)

        /// Largest title text (h1).
        public static let title1 = FontStyle(rawValue: 1 << 1)

        /// Second-level title text (h2).
        public static let title2 = FontStyle(rawValue: 1 << 2)

        /// Third-level title text (h3).
        public static let title3 = FontStyle(rawValue: 1 << 3)

        /// Fourth-level title text (h4).
        public static let title4 = FontStyle(rawValue: 1 << 4)

        /// Fifth-level title text (h5).
        public static let title5 = FontStyle(rawValue: 1 << 5)

        /// Sixth-level title text (h6).
        public static let title6 = FontStyle(rawValue: 1 << 6)

        /// Monospace font used for code blocks.
        public static let codeBlock = FontStyle(rawValue: 1 << 7)

        /// All title text styles (`title1` through `title6`).
        public static let allTitles: FontStyle = [
            .title1,
            .title2,
            .title3,
            .title4,
            .title5,
            .title6
        ]
    }

    /// Defines how wide the main content area should be.
    public enum ContentWidth: Sendable, Hashable, Equatable {
        /// Uses an absolute width in points.
        case fixed(Double)
        /// Uses a proportional width relative to the viewport (0.0–1.0).
        case proportional(Double)
    }

    /// A font size value used in theme typography.
    public enum FontSize {
        /// Sets an absolute size in points.
        case fixed(Double)
        /// Sets a size as an `em` multiplier relative to the parent font.
        case proportional(Double)

        var value: LengthUnit {
            switch self {
            case .fixed(let value): .px(value)
            case .proportional(let multiplier): .rem(multiplier)
            }
        }
    }

    /// Primary brand color
    var accent: Color?

    /// Default text color for body content
    var foreground: Color?

    /// Default background color
    var backgroundColor: Color?

    /// Default background gradient
    var backgroundGradient: Gradient?

    /// Monospace font family
    var monospaceFont: Font?

    /// Base font family for body text
    var font: Font?

    /// Font smoothing for body text
    var fontSmoothing: FontSmoothingMode?

    /// Inline code font size
    var inlineCodeStyle: AnyStyle?

    /// Code block font size
    var codeBlockFontSize: DynamicValues<LengthUnit>?

    /// Custom font family for headings
    var headingFont: Font?

    /// Font smoothing for headings
    var headingFontSmoothing: FontSmoothingMode?

    /// Line height applied to body text.
    var bodyLineSpacing: Double?

    /// Line height applied to title1 (H1) text.
    var h1LineSpacing: Double?

    /// Line height applied to title2 (H2) text.
    var h2LineSpacing: Double?

    /// Line height applied to title3 (H3) text.
    var h3LineSpacing: Double?

    /// Line height applied to title4 (H4) text.
    var h4LineSpacing: Double?

    /// Line height applied to title5 (H5) text.
    var h5LineSpacing: Double?

    /// Line height applied to title6 (H6) text.
    var h6LineSpacing: Double?

    /// Line height applied to code block text.
    var codeBlockLineSpacing: Double?

    /// The color scheme for syntax highlighting
    var inlineCodeTheme: (any SyntaxHighlighterTheme)?

    /// The color scheme for syntax highlighting
    var syntaxHighlighterTheme: (any SyntaxHighlighterTheme)?

    /// Base font size
    var bodyFontSize: DynamicValues<LengthUnit>?

    /// Font size for h1 elements
    var h1Size: DynamicValues<LengthUnit>?

    /// Font size for h2 elements
    var h2Size: DynamicValues<LengthUnit>?

    /// Font size for h3 elements
    var h3Size: DynamicValues<LengthUnit>?

    /// Font size for h4 elements
    var h4Size: DynamicValues<LengthUnit>?

    /// Font size for h5 elements
    var h5Size: DynamicValues<LengthUnit>?

    /// Font size for h6 elements
    var h6Size: DynamicValues<LengthUnit>?

    /// Base font weight
    var bodyWeight: Font.Weight?

    /// Font weight for h1 elements
    var h1Weight: Font.Weight?

    /// Font weight for h2 elements
    var h2Weight: Font.Weight?

    /// Font weight for h3 elements
    var h3Weight: Font.Weight?

    /// Font weight for h4 elements
    var h4Weight: Font.Weight?

    /// Font weight for h5 elements
    var h5Weight: Font.Weight?

    /// Font weight for h6 elements
    var h6Weight: Font.Weight?

    /// Font weight for code blocks
    var codeBlockWeight: Font.Weight?

    /// The maximum width of the site's content at different breakpoints.
    var maxContentWidth: LengthUnit?
}
