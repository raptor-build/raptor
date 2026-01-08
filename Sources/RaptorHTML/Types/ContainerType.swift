//
// ContainerType.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents the CSS `container-type` property, which determines
/// how an element establishes a container query sizing context.
public enum ContainerType: String, Sendable, Hashable, CaseIterable {
    /// Establishes a container using the inline axis (`inline-size`).
    case inline

    /// Establishes a container using the block axis (`block-size`).
    case block

    /// Establishes a container using both axes (`size`).
    case size

    /// The corresponding CSS value for this container type.
    var css: String {
        switch self {
        case .inline: "inline-size"
        case .block: "block-size"
        case .size: "size"
        }
    }
}
