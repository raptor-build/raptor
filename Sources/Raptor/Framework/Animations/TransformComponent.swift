//
// TransformComponent.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A component describing a single transformation applied at this frame.
/// Multiple components are combined into a single resolved transform.
enum TransformComponent: Hashable, Sendable {
    /// Scales the content by the given horizontal and vertical factors.
    case scale(x: Double, y: Double)

    /// Moves the content by the specified horizontal and vertical offset.
    case translate(x: Double, y: Double)

    /// Rotates the content by the specified number of degrees.
    case rotate(Double)
}
