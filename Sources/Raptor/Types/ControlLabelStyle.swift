//
// ControlLabelStyle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Controls how form labels are displayed
public enum ControlLabelStyle: CaseIterable, Sendable {
    /// Labels appear above their fields
    case top
    /// Labels appear to the left of their fields
    case leading
    /// No labels are shown
    case hidden

    var labelClass: String {
        switch self {
        case .top:     "control-label-top"
        case .leading: "control-label-leading"
        case .hidden:  "control-label-hidden"
        }
    }

    var formClass: String {
        switch self {
        case .top:     "form-top"
        case .leading: "form-leading"
        case .hidden:  "form-hidden-labels"
        }
    }
}
