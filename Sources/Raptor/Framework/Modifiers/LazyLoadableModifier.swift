//
// LazyLoadable.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A protocol that determines which elements can be loaded lazily.
public protocol LazyLoadable {}

public extension HTML where Self: LazyLoadable {
    /// Enables lazy loading for this element.
    /// - Returns: A modified copy of the element with lazy loading enabled
    func lazy() -> some HTML {
        self.customAttribute(name: "loading", value: "lazy")
    }
}
