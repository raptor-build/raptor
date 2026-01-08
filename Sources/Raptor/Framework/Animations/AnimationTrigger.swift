//
// AnimationTrigger.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the events that can trigger an animation on an HTML element.
public enum AnimationTrigger: String, Hashable, CaseIterable, Sendable {
    /// Animation triggers when the element is clicked/tapped
    case tap

    /// Animation triggers when the mouse hovers over the element
    case hover

    /// Animation triggers when the element first appears in the viewport
    case entry

    /// Optional CSS class name associated with this trigger.
    /// `nil` means no explicit class should be applied (e.g. `.hover` uses a pseudo-class).
    var cssClass: String? {
        switch self {
        case .tap: "tapped"
        default: nil
        }
    }
}
