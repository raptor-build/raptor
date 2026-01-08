//
// Style+Hidden.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension Stylable {
    /// Hides the view in the view hierarchy.
    func hidden() -> Self {
        self.style(.display(.none))
    }
}
