//
// BorderSpacing.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines spacing between adjacent table cell borders.
///
/// Example:
/// ```swift
/// .borderSpacing(.init(horizontal: .em(1), vertical: .em(0.5)))
/// ```
public struct BorderSpacing: Sendable, Hashable {
    let horizontal: LengthUnit
    let vertical: LengthUnit?

    var css: String {
        if let vertical {
            return "\(horizontal.css) \(vertical.css)"
        } else {
            return horizontal.css
        }
    }

    /// Creates equal horizontal and vertical spacing.
    public static func all(_ value: LengthUnit) -> Self {
        .init(horizontal: value, vertical: nil)
    }

    /// Creates separate horizontal and vertical spacing.
    public init(horizontal: LengthUnit, vertical: LengthUnit? = nil) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
}
