//
// ScrollViewItemSizing.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how a child view participates in the layout of a scroll view.
public enum ScrollViewItemSizing: Sendable {

    /// Sizes the item to fit its intrinsic content.
    case fitted

    /// Expands the item to fill the visible scroll view container
    /// along the scroll axis.
    case flexible

    /// The default sizing behavior, automatically chosen based on
    /// the item’s content and surrounding layout context.
    public static var automatic: Self {
        .fitted
    }

    var width: String {
        switch self {
        case .fitted: "auto"
        case .flexible: "100%"
        }
    }
}
