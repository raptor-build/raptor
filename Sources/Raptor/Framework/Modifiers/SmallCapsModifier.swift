//
// SmallCaps.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Converts lowercase letters to small capitals while leaving uppercase letters unchanged.
    /// - Returns: A modified copy of the element with small caps applied
    func smallCaps() -> some HTML {
        self.style(.fontVariant(.smallCaps))
    }
}

public extension InlineContent {
    /// Converts lowercase letters to small capitals while leaving uppercase letters unchanged.
    /// - Returns: A modified copy of the element with small caps applied
    func smallCaps() -> some InlineContent {
        self.style(.fontVariant(.smallCaps))
    }
}
