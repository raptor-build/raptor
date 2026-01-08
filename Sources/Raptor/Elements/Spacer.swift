//
// Spacer.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Creates vertical space of a specific value.
public struct Spacer: HTML {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The amount of space to occupy.
    private var spacingAmount: SpacingAmount

    /// Whether the spacer is used horizontally or vertically.
    private var axis: Axis = .vertical

    /// Creates a new `Spacer` that uses all available space.
    public init() {
        spacingAmount = .automatic
    }

    /// Creates a new `Spacer` with a size in pixels of your choosing.
    /// - Parameter size: The amount of vertical space this `Spacer`
    /// should occupy.
    public init(size: Double) {
        spacingAmount = .exact(size)
    }

    /// Creates a new `Spacer` using adaptive sizing.
    /// - Parameter size: The amount of margin to apply, specified as a
    /// `SpacingAmount` case.
    public init(size: SemanticSpacing) {
        spacingAmount = .semantic(size)
    }

    /// Configures the axis of this spacer.
    /// - Parameter axis: The lateral direction of the spacer.
    /// - Returns: A new `Spacer` with the specified axis.
    func axis(_ axis: Axis) -> Self {
        var copy = self
        copy.axis = .horizontal
        return copy
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        if case .automatic = spacingAmount {
            Section {}
                .class(axis == .horizontal ? "ms-auto" : nil)
                .class(axis == .vertical ? "mt-auto" : nil)
                .class("spacer")
                .render()
        } else if case let .semantic(spacingAmount) = spacingAmount {
            Section {}
                .margin(axis == .vertical ? .top : .leading, spacingAmount)
                .class("spacer")
                .render()
        } else if case let .exact(int) = spacingAmount {
            Section {}
                .frame(width: axis == .horizontal ? Int(int) : nil)
                .frame(height: axis == .vertical ? Int(int) : nil)
                .class("spacer")
                .render()
        } else {
            fatalError("Unknown spacing amount: \(String(describing: spacingAmount))")
        }
    }
}
