//
// PageMetadata.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// A single flattened page from any source – static or dynamic – ready to be
/// passed through a theme.
public struct PageMetadata: Sendable {
    /// The display title of the page.
    private(set) public var title: String

    /// A short descriptive summary of the page’s content.
    private(set) public var description: String

    /// The canonical URL where the page will be accessible.
    private(set) public var url: URL

    /// An optional preview image associated with the page.
    private(set) public var image: URL?

    /// Creates new page metadata with the given descriptive properties.
    package init(title: String, description: String, url: URL, image: URL? = nil) {
        self.title = title
        self.description = description
        self.url = url
        self.image = image
    }
}

extension PageMetadata {
    /// Creates an empty page for use as a default value
    static let empty = PageMetadata(
        title: "",
        description: "",
        url: URL(string: "about:blank")!
    )
}
