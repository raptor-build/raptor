//
// PostPage.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Post pages describe custom page structures for posts. You can provide
/// one page in your site to use that for all posts, or create custom pages and
/// assign them uniquely to individual posts.
///
/// ```swift
/// struct MyPost: PostPage {
///     var body: HTML {
///         Text(post.title)
///             .font(.title1)
///         Text(post.description)
///     }
/// }
/// ```
public protocol PostPage: PageRepresentable {}

public extension PostPage {
    /// The current Markdown content being rendered.
    var post: Post {
        guard let context = RenderingContext.current else {
            fatalError("PostPage/post accessed outside of a rendering context.")
        }
        return context.activePost
    }
}
