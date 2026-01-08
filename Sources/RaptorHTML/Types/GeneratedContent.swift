//
// GeneratedContent.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines generated content for pseudo-elements such as `::before` or `::after`.
///
/// Example:
/// ```swift
/// .content(.string("★"))
/// ```
public enum GeneratedContent: Sendable, Hashable {
    case none
    case normal
    case string(String)
    case attr(String)
    case openQuote
    case closeQuote
    case noOpenQuote
    case noCloseQuote

    var css: String {
        switch self {
        case .none: "none"
        case .normal: "normal"
        case .string(let text): "\"\(text)\""
        case .attr(let name): "attr(\(name))"
        case .openQuote: "open-quote"
        case .closeQuote: "close-quote"
        case .noOpenQuote: "no-open-quote"
        case .noCloseQuote: "no-close-quote"
        }
    }
}
