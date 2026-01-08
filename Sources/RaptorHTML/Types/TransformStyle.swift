//
// TransformStyle.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Specifies how nested elements are rendered in 3D space.
///
/// Example:
/// ```swift
/// .transformStyle(.preserve3d)
/// ```
public enum TransformStyle: String, Sendable, Hashable {
    /// Child elements are flattened into the 2D plane of the element.
    case flat
    /// Child elements preserve their 3D position.
    case preserve3d = "preserve-3d"

    var css: String { rawValue }
}
