//
// CSSBuilder.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

typealias RulesetBuilder = CSSBuilder<Ruleset>
typealias InlineStyleBuilder = CSSBuilder<Property>

/// A generic result builder for creating arrays of CSS elements (Ruleset or InlineStyle)
@resultBuilder
package struct CSSBuilder<Element>: Sendable {
    package static func buildBlock(_ components: Element...) -> [Element] {
        components
    }

    package static func buildBlock(_ components: Element) -> [Element] {
        [components]
    }

    package static func buildBlock(_ components: [Element]) -> [Element] {
        components
    }

    package static func buildOptional(_ component: [Element]?) -> [Element] {
        component ?? []
    }

    package static func buildEither(first component: [Element]) -> [Element] {
        component
    }

    package static func buildEither(second component: [Element]) -> [Element] {
        component
    }

    package static func buildArray(_ components: [[Element]]) -> [Element] {
        components.flatMap { $0 }
    }

    package static func buildExpression(_ expression: [Element]) -> [Element] {
        expression
    }

    package static func buildExpression(_ expression: Element) -> [Element] {
        [expression]
    }

    package static func buildExpression(_ expression: Element?) -> [Element] {
        expression.map { [$0] } ?? []
    }

    package static func buildExpression(_ expression: [Element?]) -> [Element] {
        expression.compactMap { $0 }
    }

    package static func buildBlock(_ components: [Element]...) -> [Element] {
        components.flatMap { $0 }
    }
}
