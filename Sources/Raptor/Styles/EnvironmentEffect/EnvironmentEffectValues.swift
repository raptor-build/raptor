//
// EnvironmentEffectValues.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A collection of environment dimensions that can drive responsive effects.
public struct EnvironmentEffectValues {
    public let horizontalSizeClass: HorizontalSizeClass.Type = HorizontalSizeClass.self
    public let layoutOrientation: Orientation.Type = Orientation.self
    public let contrastLevel: ContrastLevel.Type = ContrastLevel.self
    public let transparencyLevel: TransparencyLevel.Type = TransparencyLevel.self
    public let displayMode: DisplayMode.Type = DisplayMode.self
}
