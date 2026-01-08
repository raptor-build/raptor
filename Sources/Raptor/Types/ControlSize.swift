//
// ControlSize.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the size of a control element
public enum ControlSize: String, CaseIterable, Sendable {
    case mini = "xs"
    case small = "sm"
    case regular = "md"
    case large = "lg"
    case xLarge = "xl"

    var cssClass: String {
        "ctrl-\(rawValue)"
    }
}
