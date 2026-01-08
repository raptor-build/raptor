//
// AnimationModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Modifier that applies transition properties to HTML elements.
struct AnimationModifier: HTMLModifier {
    /// The timing curve for the transition.
    var timingCurve: TimingCurve?

    func body(content: Content) -> some HTML {
        var modified = content
        if let timingCurve {
            modified.attributes.append(styles:
                .variable("anim-duration", value: "\(timingCurve.baseDuration)s"),
                .variable("anim-easing", value: timingCurve.curve))
        } else {
            modified.attributes.append(styles: .variable("anim-duration", value: "0s"))
        }
        return modified
    }
}

public extension HTML {
    /// Applies a default transition to this element.
    /// - Returns: A modified copy of the element with transition applied
    func animation() -> some HTML {
        modifier(AnimationModifier(timingCurve: .automatic))
    }

    /// Applies a transition to this element.
    /// - Returns: A modified copy of the element with transition applied
    func animation(_ curve: TimingCurve?) -> some HTML {
        modifier(AnimationModifier(timingCurve: curve))
    }
}
