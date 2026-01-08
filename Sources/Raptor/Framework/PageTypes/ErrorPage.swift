//
// ErrorPage.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Allows you to define a custom error page for your site.
///
/// The error page is a special page that is shown when a specific status code or error is encountered.
///
/// ```swift
/// struct MyErrorPage: ErrorPage {
///     var body: some HTML {
///         Section {
///             Text(error.title)
///                 .font(.title1)
///             Text(error.description)
///             Link("Go back to the homepage", target: "/")
///                 .buttonStyle(.primary)
///         }
///     }
/// }
/// ```
///
/// - Note: Raptor currently supports only 404 HTTP errors.
public protocol ErrorPage: PageRepresentable {
    /// The current HTTP error being rendered.
    var error: any HTTPError { get }

    /// The title of the error page. Defaults to the title of the error.
    var title: String { get }

    /// The description of the error page. Defaults to the description of the error.
    var description: String { get }
}

extension ErrorPage {
    public var error: any HTTPError {
        guard let context = RenderingContext.current else {
            fatalError("ErrorPage/error accessed outside of a rendering context.")
        }
        return context.httpError
    }

    public var title: String {
        error.title
    }

    public var description: String {
        error.description
    }
}
