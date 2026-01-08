//
// CategoryPage.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Category pages show all posts on your site that match a specific category,
/// or all posts period if `category` is `nil`. You get to decide what is shown
/// on those pages by making a custom type that conforms to this protocol.
///
/// ```swift
/// struct MyCategoryPage: CategoryPage {
///     var body: some HTML {
///          Text(category.name)
///             .font(.title1)
///
///          List(category.posts) { post in
///             Link(post)
///         }
///     }
/// }
/// ```
public protocol CategoryPage: PageRepresentable {}

extension CategoryPage {
    /// The current tag during page generation.
    public var category: any Category {
        guard let context = RenderingContext.current else {
            fatalError("CategoryPage/category accessed outside of a rendering context.")
        }
        return context.activeCategory
    }
}
