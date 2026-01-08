//
// ControlShape.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the shape/corner radius of a button
public enum ControlShape: String, CaseIterable {
    /// Fully rounded capsule shape (9999px border radius)
    case capsule = "capsule"
    /// Default rounded corners (6px border radius)
    case roundedRect = "rounded"
    /// Sharp corners with no border radius
    case rect = "rect"

    var cssClass: String {
        "ctrl-\(rawValue)"
    }
}
