//
// ThemeEnvironmentEffectValues.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Environment values for applying theme-based style effects.
public struct ThemeEnvironmentEffectValues {
    public let theme: (any Theme).Type = (any Theme).self
}
