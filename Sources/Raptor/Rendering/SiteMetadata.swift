//
// SiteMetadata.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// The core metadata of your website, such as name, description, and URL.
public struct SiteMetadata: Sendable {
    /// The name of the site
    public let name: String

    /// A string to append to the end of page titles
    public let titleSuffix: String

    /// An optional description for the site
    public let description: String?

    /// The base URL for the site
    public let url: URL
}

extension SiteMetadata {
    /// Creates an empty page for use as a default value
    static let empty = SiteMetadata(
        name: "",
        titleSuffix: "",
        description: "",
        url: URL(string: "about:blank")!
    )
}
