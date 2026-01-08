//
// PrimitiveLinkStyle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Standard system link presentation styles.
public enum PrimitiveLinkStyle: Sendable {
    /// Uses the default link appearance.
    case automatic

    /// Styles the link to appear as a button.
    case button

    /// The CSS class associated with the link style.
    var cssClass: String? {
        switch self {
        case .automatic: nil
        case .button: "btn"
        }
    }
}
