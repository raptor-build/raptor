//
// PresentationContext.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Stores configuration for how a presentation—such as a popover or modal—
/// should appear.
///
/// A `PresentationContext` keeps track of simple presentation behaviors,
/// like whether the view can be dismissed and what visual treatment appears
/// behind it.
struct PresentationContext: Sendable {
    /// The available backdrop styles for a presentation.
    enum PresentationBackground {
        /// A solid color backdrop.
        case color(Color)

        /// A gradient backdrop.
        case gradient(Gradient)

        /// A blurred backdrop, expressed in pixels.
        case blur(Int)

        /// Returns the CSS property representing this backdrop.
        var style: Property {
            switch self {
            case .color(let color):
                .variable("presentation-backdrop", value: color.description)
            case .gradient(let gradient):
                .variable("presentation-backdrop-image", value: gradient.description)
            case .blur(let pixels):
                .variable("presentation-backdrop-filter", value: "blur(\(pixels)px)")
            }
        }
    }

    /// Whether the presentation can be dismissed by the user.
    var isDismissible = true

    /// The visual backdrop shown behind the presented content.
    var background: PresentationBackground?
}
