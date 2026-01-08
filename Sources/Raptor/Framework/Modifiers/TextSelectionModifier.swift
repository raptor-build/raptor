//
// TextSelection.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Controls whether the user can select the text inside this element or not.
public enum TextSelection: String, CaseIterable, Sendable {
    case automatic = "auto"
    case all
    case text
    case none

    var property: UserSelect {
        switch self {
        case .automatic: .auto
        case .all: .all
        case .text: .text
        case .none: .none
        }
    }
}

public extension HTML {
    /// Adjusts whether the user can select the text inside this element. You of course
    /// welcome to use this how you see fit, but please exercise restraint – not only
    /// does disabling selection annoy some people, but it can cause a genuine
    /// accessibility problem if you aren't careful.
    /// - Parameter selection: The new text selection value.
    /// - Returns: A copy of the current element with the updated text selection value.
    /// - Warning: This modifier relies on a feature with limited browser support
    /// and is best used as a progressive enhancement.
    func textSelection(_ selection: TextSelection) -> some HTML {
        self.style(.userSelect(selection.property))
    }
}
