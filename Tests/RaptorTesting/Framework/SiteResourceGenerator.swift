//
// SiteResourceGenerator.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Testing
@testable import Raptor

@Suite("SiteResourceGenerator Font Parsing Tests")
struct SiteResourceGeneratorTests {
    /// Creates a minimal SiteResourceGenerator suitable for unit testing
    private func makeGenerator() -> SiteResourceGenerator {
        let site = TestSite()
        let tempRoot = FileManager.default.temporaryDirectory
            .appending(path: UUID().uuidString)
        let buildDirectory = tempRoot.appending(path: "Build")

        return SiteResourceGenerator(
            rootDirectory: tempRoot,
            buildDirectory: buildDirectory,
            buildContext: BuildContext(),
            siteContext: site.context
        )
    }

    @Test("Parses regular named weight")
    func parsesRegularNamedWeight() {
        let generator = makeGenerator()
        let result = generator.parseFontFilename("Inter-Regular.ttf")

        #expect(result != nil)
        #expect(result?.family == "Inter")
        #expect(result?.weight == .regular)
        #expect(result?.variant == .normal)
    }

    @Test("Parses numeric weight")
    func parsesNumericWeight() {
        let generator = makeGenerator()
        let result = generator.parseFontFilename("Inter-400.ttf")

        #expect(result != nil)
        #expect(result?.family == "Inter")
        #expect(result?.weight == .regular)
        #expect(result?.variant == .normal)
    }

    @Test("Parses numeric italic without separator")
    func parsesNumericItalicCompact() {
        let generator = makeGenerator()
        let result = generator.parseFontFilename("Inter-400Italic.ttf")

        #expect(result != nil)
        #expect(result?.family == "Inter")
        #expect(result?.weight == .regular)
        #expect(result?.variant == .italic)
    }

    @Test("Parses numeric italic with dash")
    func parsesNumericItalicDashed() {
        let generator = makeGenerator()
        let result = generator.parseFontFilename("Inter-400-Italic.ttf")

        #expect(result != nil)
        #expect(result?.family == "Inter")
        #expect(result?.weight == .regular)
        #expect(result?.variant == .italic)
    }

    @Test("Parses bold italic combined token")
    func parsesBoldItalic() {
        let generator = makeGenerator()
        let result = generator.parseFontFilename("Inter-BoldItalic.ttf")

        #expect(result != nil)
        #expect(result?.family == "Inter")
        #expect(result?.weight == .bold)
        #expect(result?.variant == .italic)
    }

    @Test("Defaults to regular when weight is missing")
    func defaultsToRegularWhenMissingWeight() {
        let generator = makeGenerator()
        let result = generator.parseFontFilename("Inter.ttf")

        #expect(result != nil)
        #expect(result?.family == "Inter")
        #expect(result?.weight == .regular)
        #expect(result?.variant == .normal)
    }

    @Test("Unknown weight token falls back to regular")
    func unknownWeightFallsBackToRegular() {
        let generator = makeGenerator()
        let result = generator.parseFontFilename("Inter-SuperHeavy.ttf")

        #expect(result != nil)
        #expect(result?.family == "Inter")
        #expect(result?.weight == .regular)
        #expect(result?.variant == .normal)
    }

    @Test("Parses oblique variant")
    func parsesObliqueVariant() {
        let generator = makeGenerator()
        let result = generator.parseFontFilename("Inter-500Oblique.ttf")

        #expect(result != nil)
        #expect(result?.family == "Inter")
        #expect(result?.weight == .medium)
        #expect(result?.variant == .oblique)
    }
}
