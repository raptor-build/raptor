//
// Disclosure.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// One item inside an accordion.
public struct Disclosure<Label: InlineContent, Content: HTML>: HTML {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The attributes of the disclosure's label.
    private var summaryAttributes = CoreAttributes()

    /// The label to show for this item. Clicking this label will display the
    /// item's contents.
    private var label: Label

    /// The contents of this accordion item.
    private var content: Content

    /// Whether this disclosure group appears open initially.
    private var isExpanded: Bool

    /// The ID that links this disclosure with others in the same group.
    private var groupID: String?

    /// The disclosure label's indicator.
    private var indicator: DisclosureIndicator?

    /// Unique ID for this disclosure group
    private let uniqueID = UUID().uuidString.truncatedHash

    /// Creates a new `Item` object from the provided title and contents.
    /// - Parameters:
    ///   - header: The title to use as the header for this accordion item.
    ///   - isExpanded: Set this to `true` when this item should be open when
    ///   your page is initially loaded.
    ///   - content: A block element builder that creates the contents
    ///   for this accordion item.
    public init(
        _ titleKey: String,
        isExpanded: Bool = false,
        @HTMLBuilder content: () -> Content
    ) where Label == String {
        self.label = Localizer.string(titleKey, locale: Self.locale)
        self.isExpanded = isExpanded
        self.content = content()
    }

    /// Creates a new `Item` object from the provided title and contents.
    /// - Parameters:
    ///   - isExpanded: Set this to `true` when this item should be open when
    ///   your page is initially loaded.
    ///   - content: A block element builder that creates the contents
    ///   for this accordion item.
    ///   - header: An inline element builder that creates the title to use
    ///   as the header for this accordion item.
    public init(
        isExpanded: Bool = false,
        @HTMLBuilder content: () -> Content,
        @InlineContentBuilder label: () -> Label
    ) {
        self.isExpanded = isExpanded
        self.content = content()
        self.label = label()
    }

    /// Applies a custom `ButtonStyle` to the element and registers it for CSS generation.
    /// - Parameter style: The `ButtonStyle` to apply to the button.
    /// - Returns: A new `InlineElement` with the appropriate CSS class applied.
    public func disclosureLabelStyle(_ style: some DisclosureLabelStyle) -> some HTML {
        BuildContext.register(style.resolved)
        var copy = self
        copy.summaryAttributes.append(classes: style.resolved.allClasses)
        return copy
    }

    /// Coordinates this disclosure with others sharing the same identifier so that
    /// opening one automatically closes the rest, creating accordion-style behavior.
    /// - Parameter id: A shared identifier used to group related disclosures.
    /// - Returns: A disclosure configured to participate in a coordinated group.
    public func matchedTransitionEffect(id: String) -> Self {
        var copy = self
        copy.groupID = id
        return copy
    }

    /// Sets the disclosure indicator for a specific state
    /// - Parameters:
    ///   - indicator: The type of indicator to use
    ///   - state: The state (closed, opened, or any) for this indicator
    /// - Returns: A modified disclosure with the specified indicator
    public func disclosureLabelIndicator(_ indicator: DisclosureIndicator) -> Self {
        var copy = self
        copy.indicator = indicator
        return copy
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        var detailAttributes = CoreAttributes()

        if let groupID {
            detailAttributes.append(customAttributes: .init(name: "name", value: groupID))
        }

        let summaryID = "summary-\(uniqueID)"
        let contentID = "content-\(uniqueID)"

        var summaryAttributes = summaryAttributes
        summaryAttributes.id = summaryID
        summaryAttributes.append(aria: .init(name: "aria-expanded", value: isExpanded ? "true" : "false"))
        summaryAttributes.append(aria: .init(name: "aria-controls", value: contentID))
        summaryAttributes.append(customAttributes: .init(name: "role", value: "button"))
        summaryAttributes.append(customAttributes: .init(name: "tabindex", value: "0"))

        if let indicator {
            summaryAttributes.append(styles: .variable("disc-indicator", value: "'\(indicator.codepoint)'"))
        }

        return Section {
            Tag("details") {
                Tag("summary") { label }
                    .class("summary")
                    .attributes(summaryAttributes)

                Section(content)
                    .class("disc-content")
                    .id(contentID)
                    .customAttribute(.init(name: "role", value: "region"))
                    .aria(.labelledBy, summaryID)
            }
            .customAttribute(isExpanded ? .init("open") : nil)
            .class("disclosure")
            .attributes(detailAttributes)
        }
        .attributes(attributes)
        .render()
    }
}
