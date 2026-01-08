//
// ScrollBehavior.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Scroll behavior for controlling how the scroll view handles scrolling
public enum ScrollBehavior: Equatable {
    /// Smooth scrolling without snapping
    case continuous

    /// Scroll snapping to discrete positions
    case viewAligned(ScrollSnapAlignment)

    /// Snaps views to the center of the scroll view.
    public static var viewAligned: Self {
        .viewAligned(.center)
    }

    func scrollSnapType(for axis: ScrollAxis) -> ScrollSnapType {
        switch self {
        case .continuous:
                .none
        case .viewAligned:
            if axis == .horizontal {
                .init(.x, .mandatory)
            } else {
                .init(.y, .mandatory)
            }
        }
    }
}
