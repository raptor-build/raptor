//
// FontFamily.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// A CSS font-family value.
public enum FontFamily: Sendable, Hashable {
    public enum Generic: String, Sendable, Hashable {
        case serif
        case sansSerif = "sans-serif"
        case monospace
        case cursive
        case fantasy
    }

    public enum System: String, Sendable, Hashable {
        case systemUI = "system-ui"
        case uiSerif = "ui-serif"
        case uiSansSerif = "ui-sans-serif"
        case uiMonospace = "ui-monospace"
    }

    /// Inherits the font family from the element’s parent.
    case inherit

    /// A generic CSS font family (e.g. monospace, serif).
    case generic(Generic)

    /// A specific named font family (e.g. "SF Mono", "Inter").
    case named(String)

    /// A system font keyword (e.g. system-ui).
    case system(System)

    /// A fallback list of font families.
    case list([FontFamily])

    var css: String {
        switch self {
        case .inherit:
            "inherit"
        case .generic(let generic):
            generic.rawValue
        case .named(let name):
            "'" + name + "'"
        case .system(let system):
            system.rawValue
        case .list(let families):
            families.map(\.css).joined(separator: ", ")
        }
    }
}
