//
// HorizontalAlignment.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Controls how an element is positioned horizontally within available space.
///
/// This affects the placement of the element itself, not its text content.
public enum HorizontalAlignment: Sendable, Equatable, Hashable, CaseIterable {
    /// Positions the element at the leading edge.
    case leading

    /// Centers the element horizontally.
    case center

    /// Positions the element at the trailing edge.
    case trailing

    /// Margin-based alignment style that works in all layout contexts
    /// (block, flex, grid, fixed, absolute).
    var marginStyle: Property {
        switch self {
        case .leading: .marginInlineEnd(nil)
        case .center: .marginInline(nil)
        case .trailing: .marginInlineStart(nil)
        }
    }

    var itemAlignmentStyle: Property {
        switch self {
        case .leading: .alignSelf(.start)
        case .center: .alignSelf(.center)
        case .trailing: .alignSelf(.end)
        }
    }

    var itemAlignmentClass: String {
        switch self {
        case .leading: "align-self-start"
        case .center: "align-self-center"
        case .trailing: "align-self-end"
        }
    }
}

public extension HTML {
    /// Positions this element horizontally within available space.
    /// - Parameter alignment: The horizontal placement to apply.
    /// - Returns: A modified copy of this element with horizontal alignment applied.
    func horizontalAlignment(_ alignment: HorizontalAlignment) -> some HTML {
        self.style(alignment.marginStyle)
    }
}

public extension InlineContent {
    /// Positions this element horizontally within available space.
    /// - Parameter alignment: The horizontal placement to apply.
    /// - Returns: A modified copy of this element with horizontal alignment applied.
    func horizontalAlignment(_ alignment: HorizontalAlignment) -> some InlineContent {
        self
            .style(.display(.inlineBlock))
            .style(alignment.marginStyle)
    }
}

extension HorizontalAlignment: EnvironmentEffectValue {}
