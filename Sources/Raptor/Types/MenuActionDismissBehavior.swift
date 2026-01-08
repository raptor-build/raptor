//
// MenuActionDismissBehavior.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Defines whether a menu action dismisses its menu automatically.
public enum MenuActionDismissBehavior: String, Sendable {
    /// The menu remains open until dismissed manually.
    case disabled = "manual"
    /// The menu closes automatically after the action.
    case enabled = "auto"
}
