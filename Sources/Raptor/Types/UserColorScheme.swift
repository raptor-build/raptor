//
// ColorScheme.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    typealias ColorScheme = UserColorScheme
}

public extension InlineContent {
    typealias ColorScheme = UserColorScheme
}

public extension PageRepresentable {
    typealias ColorScheme = UserColorScheme
}

public extension Layout {
    typealias ColorScheme = UserColorScheme
}

public extension PostWidget {
    typealias ColorScheme = UserColorScheme
}

public enum UserColorScheme: String, Sendable, CaseIterable {
    case automatic = "auto"
    case light
    case dark

    public var name: String {
        rawValue
    }
}
