//
// AddIdentityTraitAction.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Adds an identity trait to a specific element.
///
/// Identity traits are represented as boolean `data-*` attributes
/// and are used to activate identity-based effects.
public struct AddIdentityTrait: Action {
    private let elementIDs: [String]
    private let attribute: String

    public init<Trait: IdentityTrait>(_ trait: Trait.Type, to elementID: String) {
        self.elementIDs = [elementID]
        self.attribute = trait.attributeName
    }

    public init<Trait: IdentityTrait>(_ trait: Trait.Type, to elementIDs: [String]) {
        self.elementIDs = elementIDs
        self.attribute = trait.attributeName
    }

    public func compile() -> String {
        let ids = elementIDs.map { "'\($0)'" }.joined(separator: ", ")
        return """
        window.RaptorIdentity?.add([\(ids)], '\(attribute)');
        """
    }
}

public extension Action where Self == AddIdentityTrait {
    /// Adds the given identity trait to a specific element.
    /// - Parameters:
    ///   - trait: The identity trait type to add.
    ///   - elementID: The ID of the element to receive the trait.
    /// - Returns: An action that adds the identity trait when executed.
    static func addIdentityTrait<Trait: IdentityTrait>(
        _ trait: Trait.Type,
        to elementID: String
    ) -> Self {
        AddIdentityTrait(trait, to: elementID)
    }

    /// Adds the given identity trait to the specific elements.
    /// - Parameters:
    ///   - trait: The identity trait type to add.
    ///   - elementIDs: The IDs of the elements to receive the trait.
    /// - Returns: An action that adds the identity trait when executed.
    static func addIdentityTrait<Trait: IdentityTrait>(
        _ trait: Trait.Type,
        to elementIDs: String...
    ) -> Self {
        AddIdentityTrait(trait, to: elementIDs)
    }
}
