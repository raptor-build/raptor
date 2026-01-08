//
// SearchField.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A form that performs site-wide search.
public struct SearchField: HTML {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// This text provides a hint to users about what they can search for.
    private var prompt: String = "Search"

    /// The text displayed on the search button.
    private var searchButtonLabel = "Search"

    /// The identifier associated with this form.
    private let searchID = UUID().uuidString.truncatedHash

    /// Sets the text displayed on the search button.
    /// - Parameter label: The text to display on the button.
    /// - Returns: A modified form with the updated button text.
    public func searchButtonLabel(_ labelKey: String) -> Self {
        var copy = self
        copy.searchButtonLabel = Localizer.string(labelKey, locale: Self.locale)
        return copy
    }

    /// Sets the placeholder text for the search input field.
    /// - Parameter prompt: The text to display when the input is empty.
    /// - Returns: A modified search form with the new placeholder text.
    public func searchPrompt(_ promptKey: String) -> Self {
        var copy = self
        copy.prompt = Localizer.string(promptKey, locale: Self.locale)
        return copy
    }

    public init() {}

    public func render() -> Markup {
        Tag("form") {
            TextField("Search", prompt: prompt)
                .textContentType(.search)
                .id("search-input-\(searchID)")
                .labelStyle(.hidden)
                .customAttribute(name: "inputmode", value: "search")
                .class("search-input")

            Button(searchButtonLabel, role: .submit) {
                SearchAction()
            }
            .class("search-button")
        }
        .class("search-form")
        .customAttribute(name: "role", value: "search")
        .customAttribute(name: "onsubmit", value: "return false")
        .attributes(attributes)
        .render()
    }
}
