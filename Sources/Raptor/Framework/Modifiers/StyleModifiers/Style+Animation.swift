//
// Style+Animation.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension Stylable {
    /// Applies a transition to this element.
    /// - Returns: A modified copy of the element with transition applied
    func animation(_ curve: TimingCurve?) -> Self {
        if let curve {
            self
                .style(.variable("anim-duration", value: "\(curve.baseDuration)s"))
                .style(.variable("anim-easing", value: curve.curve))
        } else {
            self
                .style(.variable("anim-duration", value: "0s"))
        }
    }
}
