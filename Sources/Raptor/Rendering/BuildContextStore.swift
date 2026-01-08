//
// BuildContextStore.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A reference wrapper that allows a `SiteContext` value
/// to be mutated while stored inside a task-local variable.
final class BuildContextStore: Sendable {
    /// The underlying site-level rendering context being stored and mutated.
   nonisolated(unsafe) var value: BuildContext

    /// Creates a new store wrapping the given `SiteContext` value.
    init(_ value: BuildContext) {
        self.value = value
    }
}
