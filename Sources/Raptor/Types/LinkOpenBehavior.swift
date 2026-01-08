//
// LinkOpenBehavior.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// Controls where a link opens when activated.
public enum LinkOpenBehavior: Sendable, Equatable {
    /// Opens in the current window (default behavior).
    case currentWindow

    /// Opens in a new window.
    case newWindow

    /// Opens in the parent window, outside all frames.
    case parentWindow

    /// Opens in a named frame.
    case frame(String)

    /// Default link behavior (opens in current window).
    public static let automatic: Self = .currentWindow

    /// Opens in the parent frame.
    public static let frame: Self = .frame("_parent")

    /// Converts the destination to its HTML target attribute value.
    var name: String? {
        switch self {
        case .currentWindow: nil
        case .newWindow: "_blank"
        case .parentWindow: "_top"
        case .frame(let frameName): frameName
        }
    }
}
