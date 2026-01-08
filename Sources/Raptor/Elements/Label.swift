//
// Label.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A view that displays an icon and text side by side, with a default
/// spacing of 10 pixels in-between. To adjust the spacing, use `margin()`
/// on either `title` or `icon`.
public struct Label<Title: InlineContent, Icon: InlineContent>: InlineContent {
    /// Specifies where a label’s icon is positioned relative to its text.
    public enum IconPlacement: Sendable {
        /// Places the icon before the label’s text.
        case leading

        /// Places the icon after the label’s text.
        case trailing
    }

    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The text content to display alongside the icon.
    private var title: Title

    /// The icon element to display before the title.
    private var icon: Icon

    /// The placement of the icon relative to the text.
    private var iconPlacement: IconPlacement = .leading

    /// Creates a label with a string title and image icon.
    /// - Parameters:
    ///   - title: The text to display in the label.
    ///   - path: The image to use as the label's icon.
    public init(_ titleKey: String, image path: String) where Title == String, Icon == Image {
        self.title = Localizer.string(titleKey, locale: Self.locale)
        self.icon = Image(path, description: title)
    }

    /// Creates a label with a string title and a built-in icon.
    /// - Parameters:
    ///   - title: The text to display in the label.
    ///   - systemImage: An image name chosen from https://icons.getbootstrap.com.
    public init(_ titleKey: String, systemImage: String) where Title == String, Icon == Image {
        self.title = Localizer.string(titleKey, locale: Self.locale)
        self.icon = Image(systemName: systemImage, description: title)
    }

    /// Creates a label with custom title and icon content.
    /// - Parameters:
    ///   - title: A closure that returns the label's text content.
    ///   - icon: A closure that returns the label's icon content.
    public init(
        @InlineContentBuilder title: () -> Title,
        @InlineContentBuilder icon: () -> Icon
    ) {
        self.title = title()
        self.icon = icon()
    }

    /// Sets the placement of the label’s icon relative to its text.
    /// - Parameter placement: The placement of the icon relative to the label’s text.
    /// - Returns: A label that renders its icon using the specified placement.
    public func iconPlacement(_ placement: IconPlacement) -> Self {
        var copy = self
        copy.iconPlacement = placement
        return copy
    }

    /// Set the spacing between the icon and title in labels.
    public func labelIconToTitleSpacing(_ value: Double) -> Self {
        var copy = self
        let spacing = value.formatted(.nonLocalizedDecimal) + "px"
        copy.attributes.append(styles: .variable("label-gap", value: spacing))
        return copy
    }

    public func render() -> Markup {
        var attributes = attributes
        attributes.append(classes: "label")

        let iconHTML = icon.markupString()
        let titleHTML = title.markupString()

        return switch iconPlacement {
        case .leading:
            Markup("<span\(attributes)>\(iconHTML)\(titleHTML)</span>")
        case .trailing:
            Markup("<span\(attributes)>\(titleHTML)\(iconHTML)</span>")
        }
    }
}
