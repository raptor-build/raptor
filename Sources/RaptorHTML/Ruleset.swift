//
// Ruleset.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// A structured representation of a CSS ruleset including selectors and styles
package struct Ruleset: CSS {
    /// CSS selectors for this ruleset
    package var selector: Selector?

    /// CSS declarations
    package var styles: [Property]

    package init(_ selector: Selector?, styles: some RandomAccessCollection<Property> = []) {
        self.selector = selector
        self.styles = Array(styles)
    }

    package init(_ selector: Selector?, @InlineStyleBuilder styles: () -> [Property]) {
        self.selector = selector
        self.styles = styles()
    }

    package func render() -> String {
        guard !styles.isEmpty else { return "" }
        if let selector {
            let styleBlock = styles
                .map { "    " + $0.description + ";" }
                .joined(separator: "\n")

            return """
            \(selector.description) {
                \(styleBlock)
            }
            """
        } else {
            return styles.map { $0.description + ";" }.joined(separator: "\n")
        }
    }
}
