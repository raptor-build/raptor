//
// ButtonIconPlacement.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Defines where the icon should be positioned relative to the button content
public enum ButtonIconPlacement: String, CaseIterable {
    /// Icon appears before the content (leading)
    case leading
    /// Icon appears after the content (trailing)
    case trailing

    var cssClass: String {
        "btn-icon-\(rawValue)"
    }
}
