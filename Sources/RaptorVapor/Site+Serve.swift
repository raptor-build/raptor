//
// Site+Serve.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

extension Site {
    /// Prepares the site for local development and returns a `ServedSite`
    /// containing the loaded content and resolved source directory.
    /// - Parameter file: A file used to locate the site’s package root.
    /// - Returns: A `ServedSite` containing the prepared site and posts.
    mutating func serve(
        from file: StaticString = #filePath,
        buildDirectoryPath: String = ".build/raptor"
    ) async throws -> ResolvedSite {
        let context = try await preparePublishingContext(
            from: file,
            buildDirectoryPath: buildDirectoryPath)

        return .init(
            site: self,
            posts: context.content,
            rootDirectory: context.rootDirectory,
            buildContext: context.buildContext)
    }
}
