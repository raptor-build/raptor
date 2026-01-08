//
// ContentLoader.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

package struct ContentLoader {
    /// Loads Markdown into HTML components and tracks required syntax highlighters.
    var processor: PostProcessor

    /// The list of locales supported by the site,
    /// used to detect and normalize locale-prefixed paths.
    var locales: [Locale]

    /// The post widgets used throughout the site.
    var postWidgets: [any PostWidget]

    package init(
        processor: any PostProcessor,
        locales: [Locale],
        widgets: [any PostWidget]
    ) {
        self.processor = processor
        self.postWidgets = widgets
        self.locales = locales
    }

    /// Parses all Markdown content within the site's root directory.
    package func load(from rootDirectory: URL) throws -> [Post] {
        let parsedContent = try parse(rootDirectory)
        return prepare(parsedContent)
    }

    /// Parses all Markdown content within the site's root directory.
    private func parse(_ directory: URL) throws -> [Post] {
        var allContent = [Post]()
        let sourcesDirectory = directory.appending(path: "Sources")
        let postDirectory = directory.appending(path: "Posts")
        try ContentFinder.shared.find(root: postDirectory) { deploy in
            let post = try Post(
                from: deploy.url,
                resourceValues: deploy.resourceValues,
                deployPath: deploy.path,
                defaultLocale: locales.first,
                sourcesDirectory: sourcesDirectory,
                processor: processor,
                widgets: postWidgets)

            if post.isPublished {
                allContent.append(post)
            }
            return true // always continuing
        }

        // Make content be sorted newest first by default.
        return allContent.sorted(by: \.date, order: .reverse)
    }

    /// Normalizes paths, assigns locales, and prepares all parsed posts for rendering.
    ///
    /// This method inspects each post’s path to detect locale prefixes (e.g. `/it/foo`),
    /// assigns the matching locale, removes the prefix, and trims any leading or trailing slashes.
    /// The resulting paths are normalized and ready for localized publishing.
    private func prepare(_ content: [Post]) -> [Post] {
        content.map { post in
            var post = post

            if let locale = detectLocale(in: post.relativePath) {
                post.locale = locale
                post.rawPath = stripLocalePrefix(from: post.relativePath)
            } else {
                post.locale = locales.first ?? .automatic
                post.rawPath = post.relativePath
            }

            return post
        }
    }

    /// Detects a locale directory at the beginning of the specified path.
    /// - Parameter path: The full path to check, which may include a locale directory.
    /// - Returns: The detected `Locale` if a directory match is found; otherwise, `nil`.
    private func detectLocale(in path: String) -> Locale? {
        for locale in locales {
            let prefix = locale.asRFC5646.lowercased() + "/"
            if path.lowercased().hasPrefix(prefix) {
                return locale
            }
        }
        return nil
    }

    /// Removes any locale directory from the beginning of a given path.
    ///
    /// For example, `"it/foo"` becomes `"foo"`, and `"en-US/bar"` becomes `"bar"`.
    ///
    /// - Parameter path: The input path that may begin with a locale directory
    ///   representing a language or region (e.g. `"it"` or `"en-US"`).
    /// - Returns: The path with any leading locale directory removed and normalized.
    private func stripLocalePrefix(from path: String) -> String {
        var path = path
        for locale in locales {
            let prefix = locale.asRFC5646.lowercased() + "/"
            if path.lowercased().hasPrefix(prefix) {
                path.removeFirst(prefix.count)
                break
            }
        }
        return path.trimmingCharacters(in: .init(charactersIn: "/"))
    }
}
