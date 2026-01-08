//
// PublishingContext.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A fully prepared build state used for publishing or serving a site.
package struct PublishingContext {
    /// All loaded posts and content.
    package let content: [Post]

    /// The accumulated build context produced during loading and preparation.
    package let buildContext: BuildContext

    /// The root directory of the site.
    package let rootDirectory: URL

    /// The build output directory.
    package let buildDirectory: URL
}
