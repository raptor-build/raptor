//
// EnvironmentEffect.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Testing
@testable import Raptor

@Suite("EnvironmentEffect Tests")
struct EnvironmentEffectTests {
    /// Ensures that the base CSS class name derived from
    /// `String(describing:)` remains stable.
    @Test("EnvironmentEffectConfiguration baseClass is stable")
    func environmentBaseClassIsStable() {
        let config = EnvironmentEffectConfiguration<HorizontalSizeClass>.expandedConfiguration { effect, size in
            switch size {
            case .compact: effect.hidden(true)
            default: effect
            }
        }

        let expectedBaseClass = "env-\(String(describing: config).truncatedHash)"

        #expect(config.scopedStyle.baseClass == expectedBaseClass)
    }

    /// Verifies that rebuilding the same environment configuration
    /// produces the exact same base class name.
    @Test("EnvironmentEffectConfiguration baseClass is repeatable")
    func environmentBaseClassIsRepeatable() {
        func makeConfig() -> EnvironmentEffectConfiguration<HorizontalSizeClass> {
            EnvironmentEffectConfiguration<HorizontalSizeClass>.expandedConfiguration { effect, size in
                size == .compact
                    ? effect.hidden(true)
                    : effect
            }
        }

        let first = makeConfig().scopedStyle.baseClass
        let second = makeConfig().scopedStyle.baseClass
        let third = makeConfig().scopedStyle.baseClass

        #expect(first == second)
        #expect(second == third)
    }

    /// Guards against accidental identity collisions when environment
    /// effect properties differ.
    @Test("Different environment effects produce different baseClass values")
    func differentEnvironmentEffectsProduceDifferentBaseClasses() {
        let hiddenConfig =
            EnvironmentEffectConfiguration<HorizontalSizeClass>.expandedConfiguration { effect, size in
                size == .compact
                    ? effect.hidden(true)
                    : effect
            }

        let fontConfig =
            EnvironmentEffectConfiguration<HorizontalSizeClass>.expandedConfiguration { effect, size in
                size == .compact
                    ? effect.fontScale(1.25)
                    : effect
            }

        #expect(hiddenConfig.scopedStyle.baseClass != fontConfig.scopedStyle.baseClass)
    }

    /// Ensures that theme-driven effect configurations produce a
    /// stable base class name.
    @Test("ThemeEnvironmentEffectConfiguration baseClass is stable")
    func themeBaseClassIsStable() {
        withTestRenderingEnvironment {
            let config = ThemeEnvironmentEffectConfiguration.expandedConfiguration { effect, _ in
                effect.hidden(true)
            }

            let expectedBaseClass = "theme-\(String(describing: config).truncatedHash)"

            #expect(config.scopedStyle.baseClass == expectedBaseClass)
        }
    }

    /// Verifies that theme configurations expand into one variant per theme
    /// and that each variant is already theme-scoped.
    @Test("ThemeEnvironmentEffectConfiguration expands one variant per theme")
    func themeConfigurationExpandsVariantsCorrectly() {
        withTestRenderingEnvironment {
            let config = ThemeEnvironmentEffectConfiguration.expandedConfiguration { effect, _ in
                effect.hidden(true)
            }

            let scoped = config.scopedStyle

            #expect(scoped.variants.count == 2)

            for variant in scoped.variants {
                #expect(variant.mediaFeatures.isEmpty)
            }
        }
    }

    /// Ensures that boolean-driven environment effects produce
    /// a stable base class name.
    @Test("BooleanEnvironmentEffectConfiguration baseClass is stable")
    func booleanBaseClassIsStable() {
        let config =
            BooleanEnvironmentEffectConfiguration.expandedConfiguration(
                keyPath: \.isMotionReduced
            ) { effect, isReduced in
                isReduced
                    ? effect.fontScale(1.2)
                    : effect.fontScale(2.0)
            }

        let expectedBaseClass = "env-\(String(describing: config).truncatedHash)"

        #expect(config.scopedStyle.baseClass == expectedBaseClass)
    }

    /// Verifies that boolean environment effects expand into
    /// both true and false variants when both branches produce styles.
    @Test("BooleanEnvironmentEffectConfiguration expands both branches")
    func booleanConfigurationExpandsBothBranches() {
        let config =
            BooleanEnvironmentEffectConfiguration.expandedConfiguration(
                keyPath: \.isMotionReduced
            ) { effect, isReduced in
                isReduced
                    ? effect.fontScale(1.2)
                    : effect.fontScale(2.0)
            }

        let scoped = config.scopedStyle

        #expect(scoped.variants.count == 2)

        let mediaFeatures = scoped.variants.flatMap(\.mediaFeatures)

        #expect(mediaFeatures.contains { $0 as? MotionProminence == MotionProminence.decreased })
        #expect(mediaFeatures.contains { $0 as? MotionProminence == MotionProminence.standard })
    }
}
