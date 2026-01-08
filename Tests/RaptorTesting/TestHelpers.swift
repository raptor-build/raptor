//
// TestHelpers.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

/// Executes the specified closure within a scoped test rendering environment.
///
/// This method sets up a temporary `RenderingContext` and `BuildContext` configured
/// with a fresh `TestSite` . The provided closure executes with these contexts
/// active, allowing rendering operations to behave as they would during a build.
/// The environment is restored automatically when the closure returns.
///
/// - Parameter body: A closure to execute within the test rendering environment.
func withTestRenderingEnvironment<R>(_ body: () -> R) -> R {
    let site = TestSite()
    let renderingContext = RenderingContext(
        site: site.context, posts: [],
        rootDirectory: URL(static: "dev/null"),
        buildDirectory: URL(static: "dev/null"))

    return BuildContext.withNewContext {
        RenderingContext.$current.withValue(renderingContext) {
            body()
        }
    }.result
}

/// Executes an asynchronous, potentially throwing closure within a scoped
/// test rendering environment.
///
/// This method constructs a temporary `TestSite` and activates both a fresh
/// `BuildContext` and `RenderingContext` for the duration of the asynchronous
/// operation. The provided closure executes with these contexts in place,
/// allowing tests to interact with the rendering pipeline exactly as they
/// would during a real build.
///
/// - Parameter body: An asynchronous, throwing closure.
/// - Returns: The value produced by the closure.
/// - Throws: Any error thrown by the closure.
func withTestRenderingEnvironment<R>(_ body: () async throws -> R) async throws {
    let site = TestSite()
    let renderingContext = RenderingContext(
        site: site.context, posts: [],
        rootDirectory: URL(static: "dev/null"),
        buildDirectory: URL(static: "dev/null"))

    try await BuildContext.withNewContext {
        _ = try await RenderingContext.$current.withValue(renderingContext) {
            try await body()
        }
    }
}

/// Executes the provided closure within a scoped test rendering environment.
///
/// This method creates a temporary `RenderingContext` and associated build context
/// configured with a fresh `TestSite`. The context is available
/// for the duration of the closure, allowing tests to exercise
/// rendering logic under conditions that match a real build.
///
/// - Parameter body: A closure that receives the active `RenderingContext` and
///   returns a value.
/// - Returns: The value produced by the closure, after restoring the
///   surrounding rendering environment.
func withTestRenderingEnvironment<R>(_ body: (RenderingContext) -> R) -> R {
    let site = TestSite()
    let renderingContext = RenderingContext(
        site: site.context,
        posts: [],
        rootDirectory: URL(static: "dev/null"),
        buildDirectory: URL(static: "dev/null")
    )

    return BuildContext.withNewContext {
        RenderingContext.$current.withValue(renderingContext) {
            body(renderingContext)
        }
    }.result
}
