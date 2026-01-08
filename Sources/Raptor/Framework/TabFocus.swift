//
// TabFocus.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// An enum representing the `tabindex` attribute for controlling the tab order and focus behavior of HTML elements.
public enum TabFocus: Sendable {
    /// The element is focusable but not part of the tab order (equivalent to `tabindex="-1"`).
    case focusable

    /// The element is focusable and part of the natural tab order (equivalent to `tabindex="0"`).
    case automatic

    /// The element is focusable and has a custom tab order specified by the associated integer
    /// value (equivalent to `tabindex` with a positive integer).
    /// - Parameter index: A positive integer specifying the custom tab order.
    case custom(Int)

    /// The `tabindex` value corresponding to the enum case.
    var value: String {
        switch self {
        case .focusable: "-1"
        case .automatic: "0"
        case .custom(let index): "\(index)"
        }
    }

    /// The html name for this attribute
    var htmlName: String {
        "tabindex"
    }
}
