//
// RemoveIdentityTraitAction.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Removes an identity trait from a specific element.
public struct RemoveIdentityTrait: Action {
    private let elementIDs: [String]
    private let attribute: String

    public init<Trait: IdentityTrait>(_ trait: Trait.Type, from elementID: String) {
        self.elementIDs = [elementID]
        self.attribute = trait.attributeName
    }

    public init<Trait: IdentityTrait>(_ trait: Trait.Type, from elementIDs: [String]) {
        self.elementIDs = elementIDs
        self.attribute = trait.attributeName
    }

    public func compile() -> String {
        let ids = elementIDs.map { "'\($0)'" }.joined(separator: ", ")
        return """
        window.RaptorIdentity?.remove([\(ids)], '\(attribute)');
        """
    }
}

public extension Action where Self == RemoveIdentityTrait {
    /// Removes the given identity trait from a specific element.
    /// - Parameters:
    ///   - trait: The identity trait type to remove.
    ///   - elementID: The ID of the element to remove the trait from.
    /// - Returns: An action that removes the identity trait when executed.
    static func removeIdentityTrait<Trait: IdentityTrait>(
        _ trait: Trait.Type,
        from elementID: String
    ) -> Self {
        RemoveIdentityTrait(trait, from: elementID)
    }

    /// Removes the given identity trait from the specific elements.
    /// - Parameters:
    ///   - trait: The identity trait type to remove.
    ///   - elementIDs: The IDs of the elements to remove the trait from.
    /// - Returns: An action that removes the identity trait when executed.
    static func removeIdentityTrait<Trait: IdentityTrait>(
        _ trait: Trait.Type,
        from elementIDs: String...
    ) -> Self {
        RemoveIdentityTrait(trait, from: elementIDs)
    }
}
