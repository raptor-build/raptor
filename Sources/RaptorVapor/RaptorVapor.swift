//
// RaptorVapor.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

@_exported import Vapor
@_exported import Raptor
@_exported import struct Raptor.Environment

/// Renders a single Raptor page into an HTML `Response` for Vapor.
/// - Parameters:
///   - request: The incoming Vapor request.
///   - site: The resolved site configuration stored by `Application.raptor`.
///   - posts: All parsed posts available for rendering.
///   - sourceDirectory: The site’s root source directory.
///   - render: A closure that, given a `RenderingContext`, returns a single rendered page.
/// - Returns: A fully formed HTML `Response`.
func renderPage(
    for request: Request,
    in site: ResolvedSite,
    _ body: (RenderingContext) -> RenderedPage
) throws -> Response {
    let siteContext = site.context
    let locale = request.locale()
    let posts = site.posts
    let rootDirectory = site.rootDirectory

    // Build the per-request context
    let requestContext = RequestContextStore(
        appStorage: request.application.appStorage,
        requestedValues: request.requestedValues,
        serverActionIDs: []
    )

    let environment = EnvironmentValues(
        rootDirectory: rootDirectory,
        site: siteContext,
        locale: locale,
        allContent: posts
    )

    let renderer = RenderingContext(
        site: siteContext,
        locale: locale,
        posts: posts.filter { $0.locale == locale },
        rootDirectory: rootDirectory,
        buildDirectory: rootDirectory,
        environment: environment
    )

    // All rendering must happen inside synchronous `withValue` closures.
    let renderedPage = RequestContext.$current.withValue(requestContext) {
        ActiveRequest.$current.withValue(request) {
            RenderingContext.$current.withValue(renderer) {
                let (page, _) = BuildContext.withNewContext {
                    body(renderer)
                }

                return page
            }
        }
    }

    return Response(
        status: .ok,
        headers: ["Content-Type": "text/html; charset=utf-8"],
        body: .init(string: renderedPage.html)
    )
}
