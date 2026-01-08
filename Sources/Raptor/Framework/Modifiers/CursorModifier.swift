//
// Cursor.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Changes the cursor appearance of the element when hovering over the element.
    /// - Parameter cursor: The desired cursor style.
    /// - Returns: A modified copy of the element with cursor styling applied
    func cursor(_ cursor: Cursor) -> some HTML {
        self.style(.cursor(cursor.html))
    }
}

public extension InlineContent {
    /// Changes the cursor appearance of the element when hovering over the element.
    /// - Parameter cursor: The desired cursor style.
    /// - Returns: A modified copy of the element with cursor styling applied
    func cursor(_ cursor: Cursor) -> some InlineContent {
        self.style(.cursor(cursor.html))
    }
}
