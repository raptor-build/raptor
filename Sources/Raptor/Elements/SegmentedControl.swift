//
// SegmentedControl.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public struct SegmentedControl<Content: InlineContent>: HTML {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    private var content: InlineSubviewCollection

    public init(@InlineContentBuilder content: () -> Content) {
        self.content = InlineSubviewCollection(content())
    }

    public func render() -> Markup {
        BuildContext.includesSegmentedControl(true)
        return Section {
            ForEach(content.subviews()) { segment in
                segment
                    .class("segment")
            }
        }
        .attributes(attributes)
        .class("segmented-control")
        .data("selected-segment", UUID().uuidString.truncatedHash)
        .render()
    }
}
