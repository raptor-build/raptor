//
// ButtonType.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Whether this button is just clickable, or whether its submits a form.
public enum ButtonRole: String, Sendable, CaseIterable {
    /// This button does not submit a form.
    case automatic = "button"

    /// This button submits a form.
    case submit

    /// This button resets a form.
    case reset
}
