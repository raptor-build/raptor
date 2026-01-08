//
// Input.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// An input element for use in form controls.
struct Input: InlineContent {
    /// The content and behavior of this HTML.
    var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    var attributes = CoreAttributes()

    func render() -> Markup {
        Markup("<input\(attributes) />")
    }
}
