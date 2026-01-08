//
// Markup+IsInsideList.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Markdown

extension Markdown.Markup {
    /// A small helper that determines whether this markup or any parent is a list.
    var isInsideList: Bool {
        self is ListItemContainer || parent?.isInsideList == true
    }
}
