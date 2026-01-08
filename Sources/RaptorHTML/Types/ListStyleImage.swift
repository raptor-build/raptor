//
// ListStyleImage.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines an image to use as a list marker.
///
/// Example:
/// ```swift
/// .listStyleImage(.url("icon.svg"))
/// ```
public enum ListStyleImage: Sendable, Hashable {
    case none
    case url(String)

    var css: String {
        switch self {
        case .none: "none"
        case .url(let path): "url(\(path))"
        }
    }
}
