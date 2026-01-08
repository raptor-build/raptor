//
// PostText.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public struct PostText: HTML, @unchecked Sendable {
    public var body: Never { fatalError() }
    public var attributes = CoreAttributes()
    var content: String

    init(_ content: String = "") {
        self.content = content
    }

    public func render() -> Markup {
        Section(content)
            .class("markdown")
            .attributes(attributes)
            .render()
    }
}
