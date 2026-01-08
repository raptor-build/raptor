//
// Alignment.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// An alignment in both axes.
public struct Alignment: Equatable, Sendable, CaseIterable {
    /// The alignment on the horizontal axis.
    let horizontal: HorizontalAlignment

    /// The alignment on the vertical axis.
    let vertical: VerticalAlignment

    /// Creates a custom alignment value with the specified horizontal and vertical alignment guides.
    init(horizontal: HorizontalAlignment = .center, vertical: VerticalAlignment = .center) {
        self.horizontal = horizontal
        self.vertical = vertical
    }

    /// A guide that marks the top and leading edges.
    public static let topLeading = Alignment(horizontal: .leading, vertical: .top)

    /// A guide that marks the top edge.
    public static let top = Alignment(horizontal: .center, vertical: .top)

    /// A guide that marks the top and trailing edges.
    public static let topTrailing = Alignment(horizontal: .trailing, vertical: .top)

    /// A guide that marks the leading edge.
    public static let leading = Alignment(horizontal: .leading, vertical: .center)

    /// A guide that marks the center.
    public static let center = Alignment(horizontal: .center, vertical: .center)

    /// A guide that marks the trailing edge.
    public static let trailing = Alignment(horizontal: .trailing, vertical: .center)

    /// A guide that marks the bottom and leading edges.
    public static let bottomLeading = Alignment(horizontal: .leading, vertical: .bottom)

    /// A guide that marks the bottom edge.
    public static let bottom = Alignment(horizontal: .center, vertical: .bottom)

    /// A guide that marks the bottom and trailing edges.
    public static let bottomTrailing = Alignment(horizontal: .trailing, vertical: .bottom)

    /// All possible alignments.
    public static var allCases: [Alignment] {
        [.topLeading,
        .top,
        .topTrailing,
        .leading,
        .center,
        .trailing,
        .bottomLeading,
        .bottom,
        .bottomTrailing]
    }
}

extension Alignment {
    /// Alignment rules for the items of containers.
    var itemAlignmentRules: [Property] {
        var rules: [Property] = []

        switch vertical {
        case .top:
            rules.append(.alignSelf(.flexStart))
        case .center:
            rules.append(.alignSelf(.center))
        case .bottom:
            rules.append(.alignSelf(.flexEnd))
        }

        switch horizontal {
        case .leading:
            rules.append(.justifySelf(.start))
        case .center:
            rules.append(.justifySelf(.center))
        case .trailing:
            rules.append(.justifySelf(.end))
        }

        return rules
    }

    /// Grid alignment rules for container-level alignment.
    var gridAlignmentRules: [Property] {
        var rules: [Property] = []

        switch horizontal {
        case .leading:
            rules.append(.justifyItems(.start))
        case .center:
            rules.append(.justifyItems(.center))
        case .trailing:
            rules.append(.justifyItems(.end))
        }

        switch vertical {
        case .top:
            rules.append(.alignItems(.start))
        case .center:
            rules.append(.alignItems(.center))
        case .bottom:
            rules.append(.alignItems(.end))
        }

        return rules
    }

    /// Flex container alignment rules that position a frame’s contents
    /// according to the horizontal and vertical components of `Alignment`.
    var flexContainerAlignmentRules: [Property] {
        var rules: [Property] = []

        switch horizontal {
        case .leading:
            rules.append(.justifyContent(.flexStart))
        case .center:
            rules.append(.justifyContent(.center))
        case .trailing:
            rules.append(.justifyContent(.flexEnd))
        }

        switch vertical {
        case .top:
            rules.append(.alignItems(.flexStart))
        case .center:
            rules.append(.alignItems(.center))
        case .bottom:
            rules.append(.alignItems(.flexEnd))
        }

        return rules
    }

    /// Table-cell alignment rules.
    var tableCellAlignmentRules: [Property] {
        var rules: [Property] = []

        switch vertical {
        case .top:
            rules.append(.verticalAlign(.top))
        case .center:
            rules.append(.verticalAlign(.middle))
        case .bottom:
            rules.append(.verticalAlign(.bottom))
        }

        switch horizontal {
        case .leading:
            break
        case .center:
            rules.append(.textAlign(.center))
        case .trailing:
            rules.append(.textAlign(.end))
        }

        return rules
    }
}
