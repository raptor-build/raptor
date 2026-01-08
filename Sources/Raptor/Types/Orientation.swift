//
// OrientationQuery.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Applies styles based on the device orientation.
public enum Orientation: String, CaseIterable {
    /// Portrait orientation
    case portrait = "orientation: portrait"
    /// Landscape orientation
    case landscape = "orientation: landscape"
}

extension Orientation: MediaFeature {
    package var condition: String {
        rawValue
    }
}

extension MediaFeature where Self == Orientation {
    /// Creates an orientation media feature.
    /// - Parameter orientation: The orientation to apply.
    /// - Returns: An orientation media feature.
    static func orientation(_ orientation: Orientation) -> Orientation {
        orientation
    }
}

extension Orientation: EnvironmentEffectValue {}
