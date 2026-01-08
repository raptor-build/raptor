//
// DefinitionGroupContent.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

public protocol DefinitionGroupContent: HTML {
    /// Core attributes for the table-row element.
    var attributes: CoreAttributes { get set }

    /// Renders the element as markup.
    /// - Returns: The rendered markup for the element.
    func render() -> Markup
}
