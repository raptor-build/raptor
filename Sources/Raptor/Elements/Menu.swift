//
// DropdownItem.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Renders a button that presents a menu of information when pressed.
/// Can be used as a free-floating element on your page, or in
/// a `NavigationBar`.
public struct Menu<Label: InlineContent, Content: HTML>: HTML {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The attributes of the menu's dropdown.
    private var dropdownAttributes = CoreAttributes()

    /// The title for this `Dropdown`.
    private var title: Label

    /// Icon to display in the button
    private var icon: String = ""

    /// The array of items to shown in this `Dropdown`.
    private var children: SubviewCollection

    /// The array of actions to fire when the menu is pressed.
    private var actions = [any Action]()

    /// Creates a new dropdown button using a title and an element that builder
    /// that returns an array of types conforming to `DropdownItem`.
    /// - Parameters:
    ///   - title: The title to show on this dropdown button.
    ///   - items: The elements to place inside the dropdown menu.
    public init(
        _ titleKey: String,
        @HTMLBuilder items: () -> Content
    ) where Label == String {
        self.title = Localizer.string(titleKey, locale: Self.locale)
        self.children = SubviewCollection(items())
        self.icon = .init()
    }

    /// Creates a new dropdown button using a title and an element that builder
    /// that returns an array of types conforming to `DropdownItem`.
    /// - Parameters:
    ///   - title: The title to show on this dropdown button.
    ///   - items: The elements to place inside the dropdown menu.
    ///   - primaryActions: An element builder that returns an array of actions
    ///   to run when this button is pressed.
    public init(
        _ titleKey: String,
        systemImage: String,
        @HTMLBuilder items: () -> Content,
        @ActionBuilder primaryAction: () -> [any Action]
    ) where Label == String {
        self.title = Localizer.string(titleKey, locale: Self.locale)
        self.icon = systemImage
        self.children = SubviewCollection(items())
        self.actions = primaryAction()
    }

    /// Creates a new dropdown button using a title and an element that builder
    /// that returns an array of types conforming to `DropdownItem`.
    /// - Parameters:
    ///   - title: The title to show on this dropdown button.
    ///   - items: The elements to place inside the dropdown menu.
    public init(
        _ titleKey: String,
        systemImage: String,
        primaryAction: any Action,
        @HTMLBuilder items: () -> Content
    ) where Label == String {
        self.title = Localizer.string(titleKey, locale: Self.locale)
        self.icon = systemImage
        self.children = SubviewCollection(items())
        self.actions = [primaryAction]
    }

    /// Creates a new dropdown button using a title and an element that builder
    /// that returns an array of types conforming to `DropdownItem`.
    /// - Parameters:
    ///   - title: The title to show on this dropdown button.
    ///   - items: The elements to place inside the dropdown menu.
    public init(
        _ titleKey: String,
        systemImage: String,
        @HTMLBuilder items: () -> Content
    ) where Label == String {
        self.title = Localizer.string(titleKey, locale: Self.locale)
        self.icon = systemImage
        self.children = SubviewCollection(items())
    }

    /// Creates a new dropdown button using a title and an element that builder
    /// that returns an array of types conforming to `DropdownItem`.
    /// - Parameters:
    ///   - title: The title to show on this dropdown button.
    ///   - items: The elements to place inside the dropdown menu.
    ///   - primaryActions: An element builder that returns an array of actions
    ///   to run when this button is pressed.
    public init(
        _ titleKey: String,
        @HTMLBuilder items: () -> Content,
        @ActionBuilder primaryAction: () -> [any Action]
    ) where Label == String {
        self.title = Localizer.string(titleKey, locale: Self.locale)
        self.children = SubviewCollection(items())
        self.actions = primaryAction()
        self.icon = .init()
    }

    /// Creates a new dropdown button using a title and an element that builder
    /// that returns an array of types conforming to `DropdownItem`.
    /// - Parameters:
    ///   - title: The title to show on this dropdown button.
    ///   - primaryAction: The action to fire when the menu is pressed.
    ///   - items: The elements to place inside the dropdown menu.
    public init(
        _ titleKey: String,
        primaryAction: any Action,
        @HTMLBuilder items: () -> Content
    ) where Label == String {
        self.title = Localizer.string(titleKey, locale: Self.locale)
        self.children = SubviewCollection(items())
        self.actions = [primaryAction]
        self.icon = .init()
    }

    /// Creates a new dropdown button using a title and an element that builder
    /// that returns an array of types conforming to `DropdownItem`.
    /// - Parameters:
    ///   - items: The elements to place inside the dropdown menu.
    ///   - title: The title to show on this dropdown button.
    public init(
        @HTMLBuilder items: () -> Content,
        @InlineContentBuilder label: () -> Label
    ) {
        self.title = label()
        self.children = SubviewCollection(items())
        self.icon = .init()
    }

    /// Applies a custom `ButtonStyle` to the element and registers it for CSS generation.
    /// - Parameter style: The `ButtonStyle` to apply to the button.
    /// - Returns: A new `InlineElement` with the appropriate CSS class applied.
    public func menuDropdownStyle(_ style: some MenuDropdownStyle) -> some HTML {
        BuildContext.register(style.resolved)
        var copy = self
        copy.dropdownAttributes.append(classes: style.resolved.allClasses)
        return copy
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        Section {
            if actions.isEmpty {
                Button(title, systemImage: icon)
                    .data("toggle", "dropdown")
                    .class("btn-menu")
            } else {
                Section {
                    Button(title, systemImage: icon) {
                        actions
                    }
                    .class("menu-group-action")

                    Button()
                        .data("toggle", "dropdown")
                        .class("menu-group-toggle")
                }
                .class("menu-group")
            }

            Tag("ul") {
                ForEach(children) { child in
                    Tag("li") {
                        child
                    }
                }
            }
            .class("menu-dropdown", "material-ultra-thick")
            .attributes(dropdownAttributes)
        }
        .attributes(attributes)
        .class("menu btn")
        .render()
    }
}
