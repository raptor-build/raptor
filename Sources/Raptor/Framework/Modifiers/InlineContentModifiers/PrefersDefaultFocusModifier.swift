//
// PrefersDefaultFocusModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension InlineContent {
    func prefersDefaultFocus() -> some InlineContent {
        self.attribute("autofocus")
    }
}
