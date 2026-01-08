//
// IdentityEffect.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Testing
@testable import Raptor

@Suite("IdentityEffect Tests")
struct IdentityEffectTests {
    private struct TestTrait: IdentityTrait {}
    private struct OtherTrait: IdentityTrait {}

    /// Ensures that the base CSS class derived from the identity effect
    /// is stable and deterministic.
    @Test("IdentityEffect baseClass is stable")
    func identityBaseClassIsStable() {
        let effect = EmptyIdentityEffect<TestTrait>()
            .style(.custom("color", value: "red"))

        let expected = "identity-\(String(describing: effect).truncatedHash)"

        #expect(effect.scopedStyle.baseClass == expected)
    }

    /// Verifies that rebuilding the same identity effect produces
    /// the exact same base class.
    @Test("IdentityEffect baseClass is repeatable")
    func identityBaseClassIsRepeatable() {
        func makeEffect() -> ScopedStyle {
            EmptyIdentityEffect<TestTrait>()
                .style(.custom("opacity", value: "0.5"))
                .scopedStyle
        }

        let first = makeEffect().baseClass
        let second = makeEffect().baseClass
        let third = makeEffect().baseClass

        #expect(first == second)
        #expect(second == third)
    }

    /// Guards against identity collisions when different traits are used.
    @Test("Different identity traits produce different baseClass values")
    func differentTraitsProduceDifferentBaseClasses() {
        let effectA = EmptyIdentityEffect<TestTrait>()
            .style(.custom("color", value: "red"))
            .scopedStyle.baseClass

        let effectB = EmptyIdentityEffect<OtherTrait>()
            .style(.custom("color", value: "red"))
            .scopedStyle.baseClass

        #expect(effectA != effectB)
    }

    /// Ensures that the generated selector includes the correct
    /// boolean data attribute for the trait.
    @Test("IdentityEffect selector includes trait attribute")
    func selectorIncludesTraitAttribute() {
        let effect = EmptyIdentityEffect<TestTrait>()
            .style(.custom("color", value: "blue"))

        let selector = effect.scopedStyle.variants.first?.selector.description ?? ""

        #expect(selector.contains(TestTrait.attributeName))
    }

    /// Verifies that inline styles provided to the identity effect
    /// are preserved in the resolved style.
    @Test("IdentityEffect preserves inline style properties")
    func identityEffectPreservesInlineStyles() {
        let effect = EmptyIdentityEffect<TestTrait>()
            .style(.custom("background", value: "red"))
            .style(.custom("opacity", value: "0.8"))

        let properties = effect.scopedStyle.variants.first?.styleProperties ?? []

        #expect(properties.contains(.custom("background", value: "red")))
        #expect(properties.contains(.custom("opacity", value: "0.8")))
    }

    /// Ensures that trait attribute names are stable and kebab-cased.
    @Test("IdentityTrait attributeName is stable")
    func identityTraitAttributeNameIsStable() {
        let expected = "data-test-trait"
        #expect(TestTrait.attributeName == expected)
    }

    /// Verifies that AddIdentityTraitAction emits correct JS for a single element.
    @Test("AddIdentityTraitAction emits correct JS")
    func addIdentityTraitActionJS() {
        let action = AddIdentityTrait(TestTrait.self, to: "foo")
        let javaScript = action.compile()

        #expect(javaScript.contains("RaptorIdentity"))
        #expect(javaScript.contains("add"))
        #expect(javaScript.contains("foo"))
        #expect(javaScript.contains(TestTrait.attributeName))
    }

    /// Verifies that RemoveIdentityTraitAction emits correct JS.
    @Test("RemoveIdentityTraitAction emits correct JS")
    func removeIdentityTraitActionJS() {
        let action = RemoveIdentityTrait(TestTrait.self, from: "bar")
        let javaScript = action.compile()

        #expect(javaScript.contains("RaptorIdentity"))
        #expect(javaScript.contains("remove"))
        #expect(javaScript.contains("bar"))
        #expect(javaScript.contains(TestTrait.attributeName))
    }

    /// Verifies that ToggleIdentityTraitAction emits correct JS
    /// and supports multiple element IDs.
    @Test("ToggleIdentityTraitAction supports multiple IDs")
    func toggleIdentityTraitActionMultipleIDs() {
        let action = ToggleIdentityTrait(
            TestTrait.self,
            for: ["a", "b", "c"]
        )

        let javaScript = action.compile()

        #expect(javaScript.contains("toggle"))
        #expect(javaScript.contains("a"))
        #expect(javaScript.contains("b"))
        #expect(javaScript.contains("c"))
        #expect(javaScript.contains(TestTrait.attributeName))
    }
}
