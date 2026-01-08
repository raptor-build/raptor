//
// BackgroundExtensionEffectModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Controls whether a view’s background visually extends to the viewport edges.
    func backgroundExtensionEffect() -> some HTML {
        self.class("extend-bg")
    }
}
