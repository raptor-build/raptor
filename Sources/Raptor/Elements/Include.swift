//
// Include.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Lets you include arbitrary HTML on a page.
public struct Include: HTML {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The filename you want to bring in, including its extension. This file
    /// must be in your Includes directory.
    private let filename: String

    /// Creates a new `Include` instance using the provided filename.
    /// - Parameter filename: The filename you want to bring in,
    /// including its extension. This file must be in your Includes directory.
    public init(_ filename: String) {
        self.filename = filename
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        let fileURL = renderingContext.includesDirectory.appending(path: filename)

        do {
            let string = try String(contentsOf: fileURL, encoding: .utf8)
            return Markup(string)
        } catch {
            BuildContext.logWarning("""
            Failed to find \(filename) in Includes folder; \
            it has been replaced with an empty string.
            """)

            return Markup()
        }
    }
}
