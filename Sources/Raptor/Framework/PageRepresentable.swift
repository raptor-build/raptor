//
// PageRepresentable.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A protocol that allows pages of any type to use a layout.
public protocol PageRepresentable: SendableMetatype {
    /// The type of HTML content this element contains.
    associatedtype Body: HTML

    /// The content and behavior of this `HTML` element.
    @HTMLBuilder var body: Body { get }

    /// The type of layout you want this page to use.
    associatedtype LayoutType: Layout

    /// The page layout this content should use.
    var layout: LayoutType { get }
}

public extension PageRepresentable {
    /// Defaults to the main layout defined in `Site`.
    var layout: DefaultLayout {
        DefaultLayout()
    }
}

package extension PageRepresentable {
    /// Whether the page uses the site's default layout.
    var usesDefaultLayout: Bool {
        type(of: layout) == DefaultLayout.self
    }
}
