//
// ScrollView.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A scrollable container that arranges its children along a single axis.
public struct ScrollView<Content: HTML>: HTML {
    public enum ScrollDirection: Sendable {
        case forward, backward
    }

    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// Standard HTML attributes applied to the scroll container.
    public var attributes = CoreAttributes()

    /// The scroll axis (horizontal or vertical).
    private var axis: ScrollAxis = .horizontal

    /// The scroll snapping behavior.
    private var behavior: ScrollBehavior = .continuous

    /// The scrollable child views.
    private let children: SubviewCollection

    /// Unique identifier for scripted scrolling.
    private let scrollID: String

    /// Enables autoplay.
    private var isAutoplayEnabled = false

    /// Interval between autoplay steps (seconds).
    private var autoplayInterval: Double = 3.0

    /// Whether autoplay should loop.
    private var doesAutoplayLoop = true

    /// Enables CSS-based infinite scrolling.
    private var isInfiniteScrollEnabled = false

    /// Duration of the infinite scroll animation.
    private var infiniteScrollDuration: Double = 40.0

    /// The direction of the infinitely scrolling view.
    private var infiniteScrollDirection: ScrollDirection = .forward

    /// Creates a new scroll view.
    ///
    /// - Parameters:
    ///   - axis: The scroll direction. Defaults to `.horizontal`.
    ///   - id: A unique identifier used for autoplay targeting.
    ///   - content: A builder that creates the scrollable content.
    public init(
        _ axis: ScrollAxis = .horizontal,
        id: String,
        @HTMLBuilder content: () -> Content
    ) {
        self.axis = axis
        self.scrollID = id
        self.children = SubviewCollection(content())
    }

    /// Sets the scroll snapping behavior.
    public func scrollBehavior(_ behavior: ScrollBehavior) -> Self {
        var copy = self
        copy.behavior = behavior
        return copy
    }

    /// Enables automatically advancing scroll children.
    /// - Parameters:
    ///   - interval: Time between scroll steps in seconds.
    ///   - loops: Whether playback should loop.
    public func autoAdvance(every interval: Double = 3.0, loops: Bool = true) -> Self {
        var copy = self
        copy.isAutoplayEnabled = true
        copy.autoplayInterval = interval
        copy.doesAutoplayLoop = loops
        return copy
    }

    /// Enables seamless infinite scrolling.
    /// - Parameters:
    ///   - duration: Duration of one full loop in seconds.
    ///   - direction: The direction scrolling should take place.
    public func continuousScroll(
        duration: Double = 40.0,
        direction: ScrollDirection = .forward
    ) -> Self {
        var copy = self
        copy.isInfiniteScrollEnabled = true
        copy.infiniteScrollDuration = duration
        copy.infiniteScrollDirection = direction
        return copy
    }

    public func render() -> Markup {
        if isInfiniteScrollEnabled {
            return renderInfinite()
        }

        var container = baseContainer {
            renderSlides()
        }
        .id(scrollID)

        if isAutoplayEnabled {
            let dataAttributes: [Attribute] = [
                .init(name: "scroll-autoplay", value: "true"),
                .init(name: "autoplay-interval", value: "\(Int(autoplayInterval * 1000))"),
                .init(name: "autoplay-loops", value: "\(doesAutoplayLoop)"),
                .init(name: "scroll-axis", value: axis == .horizontal ? "horizontal" : "vertical")
            ]
            container.attributes.append(dataAttributes: dataAttributes)
        }

        return container.render()
    }

    private func renderInfinite() -> Markup {
        let direction = infiniteScrollDirection == .forward ? "reverse" : "normal"
        let axisValue = axis == .horizontal ? "horizontal" : "vertical"
        let axisClass = axis == .horizontal ? "scroll-view-x" : "scroll-view-y"

        return Section {
            Section {
                renderSlides()
                renderSlides().attribute("aria-hidden", "true")
            }
            .class("scroll-track")
        }
        .attributes(attributes)
        .class("scroll-view", axisClass)
        .style(.variable("scroll-duration", value: "\(infiniteScrollDuration)s"))
        .style(.variable("scroll-direction", value: direction))
        .data("scroll-axis", axisValue)
        .render()
    }

    private func baseContainer(@HTMLBuilder content: () -> some HTML) -> some HTML {
        var attributes = attributes

        if behavior != .continuous {
            attributes.append(styles: .scrollSnapType(behavior.scrollSnapType(for: axis)))
        }

        attributes.append(styles: axis == .horizontal ? .overflowX(.scroll) : .overflowY(.scroll))
        attributes.append(styles: .display(.flex))
        attributes.append(styles: .flexDirection(axis == .horizontal ? .row : .column))
        let axisClass = axis == .horizontal ? "scroll-view-x" : "scroll-view-y"

        return Section {
            content()
        }
        .class("scroll-view", axisClass)
        .attributes(attributes)
    }

    private func renderSlides() -> some HTML {
        let alignment: ScrollSnapAlignment = {
            if case .viewAligned(let alignment) = behavior {
                return alignment
            }
            return .leading
        }()

        return Tag("ul") {
            ForEach(children) { child in
                Slide(child, alignment: alignment)
            }
        }
        .class("scroll-group")
        .style(.flexDirection(axis == .horizontal ? .row : .column))
    }
}
