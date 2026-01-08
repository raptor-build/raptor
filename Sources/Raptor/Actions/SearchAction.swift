//
// SearchAction.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// An action that triggers a site-wide search by navigating to the /search page.
struct SearchAction: Action {
    func compile() -> String {
        """
        handleSearchRedirect()
        """
    }
}
