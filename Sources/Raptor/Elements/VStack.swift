//
// VStack.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A container that arranges its child elements vertically in a stack.
public struct VStack<Content: HTML>: HTML {
    /// Internal alignment model that unifies fixed and responsive modes.
    private enum VStackAlignment {
        case fixed(HorizontalAlignment)
        case responsive([String])
    }

    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The spacing between elements.
    private var spacingAmount: SpacingAmount?

    /// The child elements contained in the stack.
    private var content: Content

    /// The alignment point for positioning elements within the stack.
    private var alignment: VStackAlignment

    /// Creates a container that stacks its subviews vertically.
    /// - Parameters:
    ///   - alignment: The horizontal alignment of items within the stack. Defaults to `.center`.
    ///   - spacing: The exact spacing between elements in pixels.
    ///   - items: A view builder that creates the content of the stack.
    public init(
        alignment: HorizontalAlignment = .center,
        spacing: Double,
        @HTMLBuilder content: () -> Content
    ) {
        self.content = content()
        self.alignment = .fixed(alignment)
        self.spacingAmount = .exact(spacing)
    }

    /// Creates a container that stacks its subviews vertically.
    /// - Parameters:
    ///   - alignment: The horizontal alignment of items within the stack. Defaults to `.center`.
    ///   - spacing: The predefined size between each element.
    ///   - items: A view builder that creates the content of the stack.
    public init(
        alignment: HorizontalAlignment = .center,
        spacing: SemanticSpacing = .medium,
        @HTMLBuilder content: () -> Content
    ) {
        self.content = content()
        self.alignment = .fixed(alignment)
        self.spacingAmount = .semantic(spacing)
    }

    /// Creates a container that stacks its subviews vertically,
    /// with horizontal alignment that adapts at different breakpoints.
    /// - Parameters:
    ///   - spacing: The predefined spacing between elements.
    ///   - content: A view builder that creates the content of the stack.
    ///   - alignment: A closure that takes the current `Breakpoint` and returns
    ///   the horizontal alignment to apply at that breakpoint.
    public init(
        spacing: Double,
        @HTMLBuilder content: () -> Content,
        alignment: @escaping (HorizontalSizeClass) -> HorizontalAlignment
    ) {
        self.content = content()
        self.spacingAmount = .exact(spacing)

        let config = EnvironmentEffectConfiguration<HorizontalSizeClass>
            .expandedConfiguration { _, breakpoint in
                EmptyEnvironmentEffect().style(alignment(breakpoint).itemAlignmentStyle)
            }

        self.alignment = .responsive(config.scopedStyle.allClasses)
        BuildContext.register(config.scopedStyle)
    }

    /// Creates a container that stacks its subviews vertically,
    /// with horizontal alignment that adapts at different breakpoints.
    /// - Parameters:
    ///   - spacing: The predefined spacing between elements.
    ///   - content: A view builder that creates the content of the stack.
    ///   - alignment: A closure that takes the current `Breakpoint` and returns
    ///   the horizontal alignment to apply at that breakpoint.
    public init(
        spacing: SemanticSpacing = .medium,
        @HTMLBuilder content: () -> Content,
        alignment: @escaping (HorizontalSizeClass) -> HorizontalAlignment
    ) {
        self.content = content()
        self.spacingAmount = .semantic(spacing)

        let config = EnvironmentEffectConfiguration<HorizontalSizeClass>
            .expandedConfiguration { _, breakpoint in
                EmptyEnvironmentEffect().style(alignment(breakpoint).itemAlignmentStyle)
            }

        self.alignment = .responsive(config.scopedStyle.allClasses)
        BuildContext.register(config.scopedStyle)
    }

    public func render() -> Markup {
        var attributes = attributes.appending(classes: "vstack")

        if case let .exact(pixels) = spacingAmount {
            attributes.append(styles: .gap(.px(pixels)))
        } else if case let .semantic(amount) = spacingAmount {
            attributes.append(classes: "gap-\(amount.rawValue)")
        }

        let contentHTML = content.subviews().map {
            addAttributesToChild($0).markupString()
        }.joined()

        return Markup("<div\(attributes)>\(contentHTML)</div>")
    }

    private func addAttributesToChild(_ child: some HTML) -> some HTML {
        var attributes = CoreAttributes()

        switch alignment {
        case .fixed(let align):
            attributes.append(classes: align.itemAlignmentClass)
        case .responsive(let classes):
            attributes.append(classes: classes)
        }

        return child.attributes(attributes)
    }
}
