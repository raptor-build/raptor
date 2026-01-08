//
// FlexBasis.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents the initial main size of a flex item before free space is distributed.
public struct FlexBasis: Sendable, Hashable {
    let value: String
    var css: String { value }

    /// Creates a flex-basis value using a specific length.
    /// - Parameter unit: The base size as a `LengthUnit`.
    /// - Returns: A `FlexBasis` representing the specified length.
    public static func length(_ unit: LengthUnit) -> Self { .init(value: unit.css) }

    /// The keyword `auto`, letting the browser determine the flex-basis automatically.
    public static let auto = Self(value: "auto")

    /// The keyword `content`, sizing the flex item based on its content.
    public static let content = Self(value: "content")
}
