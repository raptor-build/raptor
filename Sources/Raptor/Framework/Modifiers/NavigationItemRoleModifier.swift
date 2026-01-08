//
// NavigationItemRoleModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Applies a semantic role within a navigation bar.
    @HTMLBuilder func navigationItemRole(_ role: NavigationItemRole) -> some HTML {
        if role == .logo {
            let homePath = renderingContext.environment.homePath
            LinkGroup(destination: homePath) { self }
        } else {
            self.class(role.rawValue)
        }
    }
}

public extension InlineContent {
    /// Applies a semantic role within a navigation bar.
    @InlineContentBuilder func navigationItemRole(_ role: NavigationItemRole) -> some InlineContent {
        if role == .logo {
            let homePath = renderingContext.environment.homePath
            Link(destination: homePath) { self }
        } else {
            self.class(role.rawValue)
        }
    }
}
