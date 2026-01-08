//
// Quotes.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Specifies quotation mark styles for nested quotes.
///
/// Example:
/// ```swift
/// .quotes(.english)
/// ```
public enum Quotes: Sendable, Hashable {
    case none
    case custom(open: String, close: String)
    case english
    case french
    case german
    case japanese

    var css: String {
        switch self {
        case .none:
            "none"
        case let .custom(open, close):
            "\"\(open)\" \"\(close)\""
        case .english:
            "\"“\" \"”\" \"‘\" \"’\""
        case .french:
            "\"«\" \"»\""
        case .german:
            "\"„\" \"“\" \"‚\" \"‘\""
        case .japanese:
            "\"「\" \"」\" \"『\" \"』\""
        }
    }
}
