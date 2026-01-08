//
// GridForm.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A grid-based form container for arranging input fields and buttons
/// into a multi-column grid layout.
public struct GridForm<Content: HTML>: HTML {
    /// Controls how labels inside a `GridForm` are displayed.
    public enum GridFormLabelStyle: Sendable, Hashable {
        /// Labels appear above their associated control.
        case top

        /// Labels remain in the HTML for accessibility, but are visually hidden.
        case hidden

        /// Internal bridging to the underlying `ControlLabelStyle`.
        var controlLabelStyle: ControlLabelStyle {
            switch self {
            case .top: .top
            case .hidden: .hidden
            }
        }

        /// The CSS class applied to the `<form>` to activate label behavior.
        var formClass: String {
            switch self {
            case .top:     "form-top"
            case .hidden:  "form-hidden-labels"
            }
        }
    }

    /// The behavior of the `HTML` view; forms do not render a body.
    public var body: Never { fatalError() }

    /// HTML attributes applied to the `<form>` element.
    public var attributes = CoreAttributes()

    /// The content (fields, buttons, etc.) inside the form.
    private var content: Content

    /// Label style applied to child controls (if they opt in).
    private var labelStyle: GridFormLabelStyle = .top

    /// The number of columns this grid should span. When empty,
    /// the column count is based on the longest row.
    private var columns = [GridItemSize]()

    /// Sets the style for form labels
    /// - Parameter style: How labels should be displayed
    /// - Returns: A modified form with the specified label style
    public func labelStyle(_ style: GridFormLabelStyle) -> Self {
        var copy = self
        BuildContext.set(style.controlLabelStyle)
        copy.labelStyle = style
        return copy
    }

    /// Creates a grid form with per-column sizing behavior.
    /// - Parameters:
    ///   - columns: An array describing how each column should size itself.
    ///   - content: A closure returning the form fields and controls.
    public init(columns: [GridItemSize], @HTMLBuilder content: () -> Content) {
        self.content = content()
        attributes.id = UUID().uuidString.truncatedHash
        self.columns = columns
    }

    /// Creates a grid form with per-column sizing behavior.
    /// - Parameter content: A closure returning the form fields and controls.
    public init(@HTMLBuilder content: () -> Content) {
        self.content = content()
        attributes.id = UUID().uuidString.truncatedHash
    }

    public func render() -> Markup {
        Grid(columns: columns) {
            content
        }
        .isForm()
        .class("form", labelStyle.formClass)
        .attributes(attributes)
        .render()
    }
}
