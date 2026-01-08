//
// SearchPage.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Allows you to define a custom search page for your site.
///
/// The search page is a special page that is shown when a specific status code or error is encountered.
///
/// ```swift
/// struct MySearchPage: SearchPage {
///     var body: some HTML {
///         Section {
///             Text("Search results for \(searchText)")
///                 .font(.title1)
///             ForEach(searchResults) { result in
///                 result.title
///             }
///         }
///     }
/// }
/// ```
public protocol SearchPage: PageRepresentable {}

public extension SearchPage {
    var searchText: String {
        "<span class=\"search-text\"></span>"
    }

    var searchResults: SearchResultCollection {
        guard let context = RenderingContext.current else {
            fatalError("SearchPage/searchResults accessed outside of a rendering context.")
        }
        return context.searchResults
    }
}
