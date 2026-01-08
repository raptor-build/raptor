//
// DisclosureIndicator.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Available disclosure indicator types
public enum DisclosureIndicator: String, CaseIterable {
    case plus
    case minus
    case arrowRight
    case arrowDown
    case chevronRight
    case chevronDown
    case caretRight
    case caretDown
    case ellipsis
    case infoCircle

    /// Bootstrap Icons codepoint for this indicator
    var codepoint: String {
        switch self {
        case .plus:          "\\F64D"
        case .minus:         "\\F63B"
        case .arrowRight:    "\\F135"
        case .arrowDown:     "\\F124"
        case .chevronRight:  "\\F285"
        case .chevronDown:   "\\F282"
        case .caretRight:    "\\F231"
        case .caretDown:     "\\F229"
        case .ellipsis:      "\\F5D4"
        case .infoCircle:    "\\F431"
        }
    }
}
