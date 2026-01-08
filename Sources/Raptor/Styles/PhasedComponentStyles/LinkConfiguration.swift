//
// LinkConfiguration.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A container describing all inline styles associated with a link across its visual phases.
public typealias LinkConfiguration = PhasedComponentConfiguration<LinkPhase>

public extension LinkConfiguration {
    /// Applies an underline decoration to the link text.
    /// - Parameters:
    ///   - isActive: A Boolean value that determines whether the underline is shown.
    ///     Defaults to `true`.
    ///   - pattern: The visual style of the underline (e.g., `.solid`, `.dotted`, `.wavy`).
    ///     Defaults to `.solid`.
    ///   - color: The color of the underline. If `nil`, the underline uses the current
    ///     text color. Defaults to `nil`.
    ///   - width: The thickness of the underline in pixels. Defaults to `1`.
    /// - Returns: A modified ``LinkConfiguration`` instance with the underline style applied.
    func underline(
        _ isActive: Bool = true,
        pattern: UnderlineStyle = .solid,
        color: Color? = nil,
        width: Double = 1
    ) -> Self {
        guard isActive else { return self }

        var result = self
            .style(.textDecoration(.underline))
            .style(.textDecorationStyle(pattern))
            .style(.textDecorationThickness(.px(width)))

        if let color {
            result = result.style(.textDecorationColor(color.html))
        }

        return result
    }
}
