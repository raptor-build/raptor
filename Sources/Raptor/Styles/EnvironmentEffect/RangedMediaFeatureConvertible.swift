//
// RangedMediaFeatureConvertible.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A type that resolves into one or more media features representing a value range.
protocol RangedMediaFeatureConvertible {
    /// The media features that describe this value’s effective range.
    var mediaFeatures: [MediaFeature] { get }
}
