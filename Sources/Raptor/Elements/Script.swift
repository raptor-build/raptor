//
// Script.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// Embeds some JavaScript inside this page, either directly or by
/// referencing an external file.
struct Script: HTML, HeadContent {
    /// The content and behavior of this HTML.
    var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    var attributes = CoreAttributes()

    /// The external file to load.
    private var file: URL?

    /// Direct, inline JavaScript code to execute.
    private var code: String?

    /// Creates a new script that references a local file.
    /// - Parameter file: The URL of the file to load.
    init(file: String) {
        self.file = URL(string: file)
    }

    /// Creates a new script that references an external file.
    /// - Parameter file: The URL of the file to load.
    init(file: URL) {
        self.file = file
    }

    /// Embeds some custom, inline JavaScript on this page.
    init(code: String) {
        self.code = code
    }

    /// Creates a new script with the given configuration.
    /// - Parameter file: The URL of the file to load.
    init(_ configuration: ScriptConfiguration) {
        self.attributes = configuration.attributes
        switch configuration.payload {
        case .file(let string):
            self.file = URL(string: string)
        case .code(let string):
            self.code = string
        }
    }

    /// Marks this script to be executed after the document has been parsed.
    func `defer`() -> Self {
        var copy = self
        copy.attributes.append(customAttributes: .init("defer"))
        return copy
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    func render() -> Markup {
        var attributes = attributes
        if let file, let path = RenderingContext.current?.path(for: file) {
            attributes.append(customAttributes: .init(name: "src", value: path))
            return Markup("<script\(attributes)></script>")
        } else if let code {
            return Markup("""
            <script\(attributes)>
            \(code)
            </script>
            """)
        } else {
            BuildContext.logWarning("""
            Creating a script with no source or code should not be possible. \
            Please file a bug report on the Raptor project.
            """)
            return Markup()
        }
    }
}
