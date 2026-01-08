//
// ToggleIdentityTrait.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Toggles an identity trait on a specific element.
public struct ToggleIdentityTrait: Action {
    private let elementIDs: [String]
    private let attribute: String

    public init<Trait: IdentityTrait>(_ trait: Trait.Type, for elementID: String) {
        self.elementIDs = [elementID]
        self.attribute = trait.attributeName
    }

    public init<Trait: IdentityTrait>(_ trait: Trait.Type, for elementIDs: [String]) {
        self.elementIDs = elementIDs
        self.attribute = trait.attributeName
    }

    public func compile() -> String {
        let ids = elementIDs.map { "'\($0)'" }.joined(separator: ", ")
        return """
        window.RaptorIdentity?.toggle([\(ids)], '\(attribute)');
        """
    }
}

public extension Action where Self == ToggleIdentityTrait {
    /// Toggles the given identity trait on a specific element.
    /// - Parameters:
    ///   - trait: The identity trait type to toggle.
    ///   - elementID: The ID of the element whose trait should be toggled.
    /// - Returns: An action that toggles the identity trait when executed.
    static func toggleIdentityTrait<Trait: IdentityTrait>(
        _ trait: Trait.Type,
        for elementID: String
    ) -> Self {
        ToggleIdentityTrait(trait, for: elementID)
    }

    /// Toggles the given identity trait on the specific elements.
    /// - Parameters:
    ///   - trait: The identity trait type to toggle.
    ///   - elementIDs: The IDs of the elements whose trait should be toggled.
    /// - Returns: An action that toggles the identity trait when executed.
    static func toggleIdentityTrait<Trait: IdentityTrait>(
        _ trait: Trait.Type,
        for elementIDs: [String]
    ) -> Self {
        ToggleIdentityTrait(trait, for: elementIDs)
    }
}
