//
// Button.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// A customizable button component with composable modifiers for style, shape, and sizing
public struct Button<Label: InlineContent>: InlineContent {
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements
    public var attributes = CoreAttributes()

    /// The label to display inside the button
    private var label: Label

    /// Whether the button is disabled
    private var isDisabled: Bool = false

    /// Icon to display in the button
    private var icon: String?

    /// Whether this button should submit a form or not. Defaults to `.automatic`.
    private var role = ButtonRole.automatic

    /// Position of the icon relative to the content
    private var iconPlacement: ButtonIconPlacement = .leading

    /// Creates a button with no label. Used in some situations where
    /// exact actions are handled by Raptor.
    init() where Label == EmptyInlineContent {
        self.label = EmptyInlineContent()
    }

    /// Creates a new button with the provided label
    /// - Parameter label: A closure that returns the label to display inside the button
    init(_ titleKey: String, role: ButtonRole = .automatic) where Label == String {
        self.label = Localizer.string(titleKey, locale: Self.locale)
        self.role = role
    }

    /// Creates a new button with the provided label
    /// - Parameter label: A closure that returns the label to display inside the button
    init(_ title: Label, systemImage: String) {
        self.label = title
        self.icon = systemImage
    }

    /// Creates a new button with the provided label
    /// - Parameter label: A closure that returns the label to display inside the button
    init(_ titleKey: String, systemImage: String) where Label == String {
        self.label = Localizer.string(titleKey, locale: Self.locale)
        self.icon = systemImage
    }

    /// Creates a button with a label.
    /// - Parameters:
    ///   - title: The label text to display on this button.
    ///   - actions: An element builder that returns an array of actions to run when this button is pressed.
    public init(
        _ titleKey: String,
        role: ButtonRole = .automatic,
        @ActionBuilder action: () -> [Action]
    ) where Label == String {
        self.label = Localizer.string(titleKey, locale: Self.locale)
        self.role = role
        addEvent(name: "onclick", actions: action())
    }

    /// Creates a button with a label.
    /// - Parameters:
    ///   - title: The label text to display on this button.
    ///   - systemImage: An image name chosen from https://icons.getbootstrap.com.
    ///   - actions: An element builder that returns an array of actions to run when this button is pressed.
    init(
        _ title: Label,
        systemImage: String,
        role: ButtonRole = .automatic,
        @ActionBuilder action: () -> [Action]
    ) {
        self.label = title
        self.icon = systemImage
        self.role = role
        addEvent(name: "onclick", actions: action())
    }

    /// Creates a button with a label.
    /// - Parameters:
    ///   - title: The label text to display on this button.
    ///   - systemImage: An image name chosen from https://icons.getbootstrap.com.
    ///   - actions: An element builder that returns an array of actions to run when this button is pressed.
    public init(
        _ titleKey: String,
        systemImage: String,
        role: ButtonRole = .automatic,
        @ActionBuilder action: () -> [Action]
    ) where Label == String {
        self.label = Localizer.string(titleKey, locale: Self.locale)
        self.icon = systemImage
        self.role = role
        addEvent(name: "onclick", actions: action())
    }

    /// Creates a button with a label.
    /// - Parameters:
    ///   - titleKey: The label text to display on this button.
    ///   - systemImage: An image name chosen from https://icons.getbootstrap.com.
    ///   - action: The action to run when this button is pressed.
    public init(
        _ titleKey: String,
        role: ButtonRole = .automatic,
        action: any Action
    ) where Label == String {
        self.label = Localizer.string(titleKey, locale: Self.locale)
        self.role = role
        addEvent(name: "onclick", actions: [action])
    }

    /// Creates a button with a label.
    /// - Parameters:
    ///   - title: The label text to display on this button.
    ///   - systemImage: An image name chosen from https://icons.getbootstrap.com.
    ///   - action: The action to run when this button is pressed.
    public init(
        _ titleKey: String,
        systemImage: String,
        role: ButtonRole = .automatic,
        action: any Action
    ) where Label == String {
        self.label = Localizer.string(titleKey, locale: Self.locale)
        self.icon = systemImage
        self.role = role
        addEvent(name: "onclick", actions: [action])
    }

    /// Creates a button with a label and actions to run when it's pressed.
    /// - Parameters:
    ///   - action: The action to run when this button is pressed.
    ///   - label: The label text to display on this button.
    public init(
        role: ButtonRole = .automatic,
        action: any Action,
        @InlineContentBuilder label: () -> Label
    ) {
        self.label = label()
        self.role = role
        addEvent(name: "onclick", actions: [action])
    }

    /// Creates a button with a label and actions to run when it's pressed.
    /// - Parameters:
    ///   - actions: An element builder that returns an array of actions to run when this button is pressed.
    ///   - label: The label text to display on this button.
    public init(
        role: ButtonRole = .automatic,
        @ActionBuilder action: () -> [Action],
        @InlineContentBuilder label: () -> Label
    ) {
        self.label = label()
        self.role = role
        addEvent(name: "onclick", actions: action())
    }

    /// Sets the position of the icon relative to the button content
    /// - Parameter placement: The position where the icon should appear
    /// - Returns: A modified button with the specified icon position
    public func buttonIconPlacement(_ placement: ButtonIconPlacement) -> Self {
        var copy = self
        copy.iconPlacement = placement
        return copy
    }

    /// Renders this button into HTML.
    /// - Returns: The HTML markup for this button element
    public func render() -> Markup {
        Tag("button") {
            if let icon = icon, !icon.isEmptyContent {
                if iconPlacement == .leading {
                    Image(systemName: icon)
                        .class("btn-icon")
                    InlineText(label)
                        .class("btn-label")
                } else {
                    InlineText(label)
                        .class("btn-label")
                    Image(systemName: icon)
                        .class("btn-icon")
                }
            } else {
                label
            }
        }
        .attributes(attributes)
        .attribute("type", role.rawValue)
        .class("btn")
        .render()
    }
}
