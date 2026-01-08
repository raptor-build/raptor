//
// SelectionPersistedModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Enables or disables persistence of the selected segment across page reloads.
    /// - Parameter persist: Whether the selection state should persist, default is `true`.
    /// - Returns: A modified HTML element with persisted selection behavior applied.
    func selectionPersisted(_ persisted: Bool = true) -> some HTML {
        self.data(persisted ? .init("persist-selection") : nil)
    }
}
