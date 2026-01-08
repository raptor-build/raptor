//
// ColorScheme.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public enum SystemColorScheme: String, Sendable, Equatable, CaseIterable {
    case light, dark
}

extension SystemColorScheme: AttributeEnvironmentEffectValue {
    public var selector: Selector {
        .attribute("data-color-scheme", value: rawValue)
    }

    public static var allValues: [Self] {
        allCases
    }
}
