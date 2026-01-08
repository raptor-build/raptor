//
// AspectRatio.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Specific aspect ratios that are commonly used
public enum AspectRatio: CaseIterable, Sendable {
    /// A square aspect ratio.
    case square

    /// A 4:3 aspect ratio.
    case r4x3

    /// A 16:9 aspect ratio.
    case r16x9

    /// A 21:9 aspect ratio.
    case r21x9

    var numericValue: Double {
        switch self {
        case .square: 1
        case .r4x3: 4.0/3.0
        case .r16x9: 16.0/9.0
        case .r21x9: 21.0/9.0
        }
    }
}
