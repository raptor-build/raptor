//
// BuildError.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// All the primary errors that can occur when building a site. There are other
/// errors that can be triggered, but they are handled through fatalError() because
/// something is seriously wrong.
package enum BuildError: LocalizedError, Hashable, Sendable, CustomStringConvertible {
    /// Could not find the site's package directory.
    case missingPackageDirectory

    /// Could not find the app sandbox's home directory
    case missingSandboxHomeDirectory

    /// Invalid Markdown was found at the specific URL.
    case badMarkdown(URL)

    /// An incorrectly formatted date was found in a piece of Content.
    case badContentDateFormat

    /// A file cannot be opened (bad encoding, etc).
    case unopenableFile(String)

    /// Publishing attempted to remove the build directory, but failed.
    case failedToRemoveBuildDirectory(URL)

    /// Publishing attempted to create the build directory, but failed.
    case failedToCreateBuildDirectory(URL)

    /// Publishing attempted to create a file during a build, but failed.
    case failedToCreateBuildFile(URL)

    /// Failed to locate one of the key Raptor resources.
    case missingSiteResource(String)

    /// Publishing attempted to copy one of the key site resources during a
    /// build, but failed.
    case failedToCopySiteResource(String)

    /// A syntax highlighter file resource was not found.
    case missingSyntaxHighlighter(String)

    /// The site lacks a default syntax-highlighter theme.
    case missingDefaultSyntaxHighlighterTheme

    /// A syntax highlighter file resource could not be loaded.
    case failedToLoadSyntaxHighlighter(String)

    /// Publishing attempted to write out the syntax highlighter data during a
    /// build, but failed.
    case failedToWriteSyntaxHighlighters

    /// Publishing attempted to write out the RSS feed during a build, but failed.
    case failedToWriteFeed

    /// Publishing attempted to write out a file during a build, but failed.
    case failedToWriteFile(String)

    /// Publishing attempted to parse markup, but failed.
    case failedToParseMarkup

    /// A Markdown file requested a named layout that does not exist.
    case missingNamedLayout(String)

    /// A post widget token referenced a widget type that was not registered.
    case missingPostWidget(String)

    /// Site attempted to render Markdown content without a layout in place.
    case missingDefaultLayout

    /// Publishing attempted to write a file at the specific URL. but it already exists.
    case duplicateDirectory(URL)

    /// A build-only value was accessed outside of its valid context.
    case failedToReadContextValue(String)

    /// Converts all errors to a string for easier reading.
    public var errorDescription: String? {
        switch self {
        case .missingPackageDirectory:
            "Unable to locate Package.swift."
        case .missingSandboxHomeDirectory:
            "Unable to locate App sandbox's home directory"
        case .badMarkdown(let url):
            "Markdown could not be parsed: \(url.absoluteString)."
        case .badContentDateFormat:
            "Content dates should be in the format 2024-05-24 15:30."
        case .unopenableFile(let reason):
            "Failed to open file: \(reason)."
        case .failedToRemoveBuildDirectory(let url):
            "Failed to clear the build folder: \(url.absoluteString)."
        case .failedToCreateBuildDirectory(let url):
            "Failed to create the build folder: \(url.absoluteString)."
        case .failedToCreateBuildFile(let url):
            "Failed to create the build folder: \(url.absoluteString)."
        case .missingSiteResource(let name):
            "Failed to locate critical site resource: \(name)."
        case .failedToCopySiteResource(let name):
            "Failed to copy critical site resource to build folder: \(name)."
        case .missingSyntaxHighlighter(let name):
            "Failed to locate syntax highlighter JavaScript: \(name)."
        case .failedToParseMarkup:
            "Failed to parse markup while rendering an element."
        case .missingDefaultSyntaxHighlighterTheme:
            "At least one of your themes must specify a syntax highlighter."
        case .failedToLoadSyntaxHighlighter(let name):
            "Failed to load syntax highlighter JavaScript: \(name)."
        case .failedToWriteSyntaxHighlighters:
            "Failed to write syntax highlighting JavaScript."
        case .failedToWriteFeed:
            "Failed to generate RSS feed."
        case .failedToWriteFile(let filename):
            "Failed to write \(filename) file."
        case .missingNamedLayout(let name):
            "Failed to find layout named \(name)."
        case .missingPostWidget(let name):
            """
            Failed to find a post widget named \(name). \
            Register the widget with your site, or use $@{…} to render the token literally.
            """
        case .missingDefaultLayout:
            "Your site must provide at least one layout in order to render Markdown."
        case .duplicateDirectory(let url):
            "Duplicate URL found: \(url). This is a fatal error."
        case .failedToReadContextValue(let name):
            """
            \(name) was accessed outside of an active build.
            This value is only available while the site is being rendered.
            """
        }
    }

    public var description: String {
        errorDescription ?? "Unknown error"
    }
}
