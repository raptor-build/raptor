//
// MenuActionDismissBehaviorModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Sets how a menu action affects menu dismissal.
/// - Parameter behavior: The dismissal behavior to apply.
/// - Returns: The modified HTML element.
public extension HTML {
    func menuActionDismissBehavior(_ behavior: MenuActionDismissBehavior) -> some HTML {
        self.data("dismiss", behavior.rawValue)
    }
}
