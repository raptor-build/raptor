//
// ThemeVariable.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A collection of CSS variables used by Raptor for theming.
enum ThemeVariable: String, Sendable {
    /// The primary brand color
    case accent = "--accent"

    /// Default text color for body content
    case foreground = "--fg"

    /// Default background color for the body
    case background = "--bg-page"

    /// Default background gradient for the body
    case backgroundGradient = "--bg-gradient"

    // MARK: - Font Families

    /// Monospace font family
    case monospaceFont = "--monospace-font-family"

    /// Base body font family
    case bodyFont = "--font-family"

    /// Font family for headings
    case headingFont = "--heading-font-family"

    // MARK: - Font Sizes

    /// Base body font size
    case bodyFontSize = "--font-size"

    /// Code block font size
    case codeBlockFontSize = "--code-block-font-size"

    // MARK: - Heading Sizes

    /// Font size for h1 elements
    case h1FontSize = "--h1-font-size"

    /// Font size for h2 elements
    case h2FontSize = "--h2-font-size"

    /// Font size for h3 elements
    case h3FontSize = "--h3-font-size"

    /// Font size for h4 elements
    case h4FontSize = "--h4-font-size"

    /// Font size for h5 elements
    case h5FontSize = "--h5-font-size"

    /// Font size for h6 elements
    case h6FontSize = "--h6-font-size"

    // MARK: - Font Weights

    /// Default body font weight.
    case bodyWeight = "--font-weight"

    /// Font weight for title1 (h1).
    case h1Weight = "--h1-weight"

    /// Font weight for title2 (h2).
    case h2Weight = "--h2-weight"

    /// Font weight for title3 (h3).
    case h3Weight = "--h3-weight"

    /// Font weight for title4 (h4).
    case h4Weight = "--h4-weight"

    /// Font weight for title5 (h5).
    case h5Weight = "--h5-weight"

    /// Font weight for title6 (h6).
    case h6Weight = "--h6-weight"

    /// Font weight for code blocks.
    case codeBlockWeight = "--codeblock-weight"

    // MARK: - Line Heights

    /// Default body line height.
    case bodyLineHeight = "--line-height"

    /// Line height for title1 (h1).
    case h1LineHeight = "--h1-line-height"

    /// Line height for title2 (h2).
    case h2LineHeight = "--h2-line-height"

    /// Line height for title3 (h3).
    case h3LineHeight = "--h3-line-height"

    /// Line height for title4 (h4).
    case h4LineHeight = "--h4-line-height"

    /// Line height for title5 (h5).
    case h5LineHeight = "--h5-line-height"

    /// Line height for title6 (h6).
    case h6LineHeight = "--h6-line-height"

    /// Line height for code blocks.
    case codeBlockLineHeight = "--codeblock-line-height"

    // MARK: - Breakpoints

    /// Small breakpoint value
    case xSmallBreakpoint = "--breakpoint-xs"

    /// Small breakpoint value
    case smallBreakpoint = "--breakpoint-sm"

    /// Medium breakpoint value
    case mediumBreakpoint = "--breakpoint-md"

    /// Large breakpoint value
    case largeBreakpoint = "--breakpoint-lg"

    /// Extra large breakpoint value
    case xLargeBreakpoint = "--breakpoint-xl"

    /// Extra extra large breakpoint value
    case xxLargeBreakpoint = "--breakpoint-xxl"
}

extension ThemeVariable: CustomStringConvertible {
    var description: String {
        rawValue
    }
}

extension ThemeVariable {
    var selector: String {
        switch self {
        case .h1FontSize: return "h1"
        case .h2FontSize: return "h2"
        case .h3FontSize: return "h3"
        case .h4FontSize: return "h4"
        case .h5FontSize: return "h5"
        case .h6FontSize: return "h6"
        case .bodyFontSize: return "body"
        default: return ""
        }
    }
}
