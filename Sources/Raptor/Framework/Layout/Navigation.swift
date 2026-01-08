//
// Navigation.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A navigation bar positioned at the top of a page.
public struct Navigation: Region {
    /// The collection of items displayed inside the navigation bar.
    private let items: SubviewCollection

    /// Attributes applied to the `<nav>` element.
    public var attributes = CoreAttributes()

    /// Attributes applied to the inner navigation container.
    private var innerAttributes = CoreAttributes()

    /// Attributes applied to the outer navigation wrapper.
    private var outerAttributes = CoreAttributes()

    /// The navigation's position within the page layout.
    var position: Position?

    /// Whether the navigation contains meaningful content.
    var isEmpty: Bool {
        items.render().isEmpty
    }

    /// Creates a navigation bar with the provided content.
    /// - Parameter content: A builder that produces the navigation items.
    public init<Content: HTML>(@HTMLBuilder _ content: () -> Content) {
        self.items = SubviewCollection(content())
    }

    public func render() -> Markup {
        Section {
            Tag("nav") {
                Tag("ul") {
                    ForEach(items) { item in
                        Tag("li") {
                            item
                        }
                    }
                }
                .class("nav-inner")
                .attributes(innerAttributes)
            }
            .attributes(attributes)
            .class("navbar")
        }
        .class("nav-outer")
        .attributes(outerAttributes)
        .render()
    }
}

public extension Navigation {
    /// Applies padding on selected sides of this element. Defaults to 20 pixels.
    /// - Parameter amount: The amount of padding to apply in pixels.
    /// - Returns: A copy of the current element with the new padding applied.
    func padding(_ amount: Int) -> Self {
        let styles = Edge.all.paddingStyles(.px(amount))
        var copy = self
        copy.innerAttributes.append(styles: styles)
        return copy
    }

    /// Applies padding on selected sides of this element. Defaults to 20 pixels.
    /// - Parameters:
    ///   - edges: The edges where this padding should be applied.
    ///   - amount: The amount of padding to apply in pixels.
    /// - Returns: A copy of the current element with the new padding applied.
    func padding(_ edges: Edge, _ amount: Int) -> Self {
        let styles = edges.paddingStyles(.px(amount))
        var copy = self
        copy.innerAttributes.append(styles: styles)
        return copy
    }

    /// Applies padding on selected sides of this element. Defaults to 20 pixels.
    /// - Parameters:
    ///   - edges: The edges where this padding should be applied.
    ///   - amount: The amount of padding to apply in pixels.
    /// - Returns: A copy of the current element with the new padding applied.
    func margin(_ edges: Edge, _ amount: Int) -> Self {
        let styles = edges.paddingStyles(.px(amount))
        var copy = self
        copy.outerAttributes.append(styles: styles)
        return copy
    }

    /// Positions an element with fixed or sticky behavior relative to the viewport.
    /// - Parameters:
    ///   - position: The desired positioning behavior (fixed/sticky top or bottom).
    ///   - offset: Optional distance from the viewport edge in pixels.
    func position(_ position: Position) -> Self {
        var copy = self
        if position == .fixedTop {
            BuildContext.current.navigationReservesSpace = true
        }
        copy.position = position
        return copy
    }

    /// Applies a background color from a `Color` object.
    /// - Parameter color: The specific color value to use, specified as
    /// a `Color` instance.
    /// - Returns: The current element with the updated background color.
    func background(_ color: Color) -> Self {
        var copy = self
        copy.innerAttributes.append(styles: .backgroundColor(color.html))
        return copy
    }

    /// Applies a material effect background
    /// - Parameter material: The type of material to apply
    /// - Returns: The modified HTML element
    func background(_ material: Material) -> Self {
        var copy = self
        copy.innerAttributes.append(classes: material.className)
        return copy
    }

    /// Rounds all edges of this object by some number of pixels.
    /// - Parameter amount: An integer specifying a pixel amount to round corners with
    /// - Returns: A modified copy of the element with corner radius applied
    func cornerRadius(_ amount: Int) -> Self {
        let styles = CornerRadiusModifier.styles(edges: .all, radius: amount)
        var copy = self
        copy.innerAttributes.append(styles: styles)
        return copy
    }

    /// Adds a border to the element when hovered.
    /// - Parameters:
    ///   - color: The color of the border.
    ///   - width: The width of the border in pixels. Defaults to `1`.
    ///   - style: The border style (e.g. `.solid`, `.dashed`, `.dotted`). Defaults to `.solid`.
    ///   - edges: The edges on which to apply the border (e.g. `.all`, `.top`, `.horizontal`). Defaults to `.all`.
    /// - Returns: A modified hover configuration with the border applied.
    func border(
        _ color: Color,
        width: Double = 1,
        style: StrokeStyle = .solid,
        edges: Edge = .all
    ) -> Self {
        var copy = self
        let styles = BorderModifier.styles(color: color, width: width, style: style, edges: edges)
        copy.innerAttributes.append(styles: styles)
        return copy
    }

    /// How the navigation bar sizes itself within the page.
    func navigationBarSizing(_ sizing: NavigationBarSizing) -> Self {
        var copy = self
        copy.attributes.append(classes: sizing.rawValue)
        if sizing == .window {
            copy.attributes.append(styles: .variable("nav-padding", value: "0"))
        }
        return copy
    }

    /// Disables reserved layout space for fixed navigation bars on this page.
    func navigationBarReservedSpaceDisabled() -> Self {
        BuildContext.current.navigationReservesSpace = false
        return self
    }
}
