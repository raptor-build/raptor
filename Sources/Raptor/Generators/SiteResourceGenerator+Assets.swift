//
// SiteResourceGenerator+Assets.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

extension SiteResourceGenerator {
    /// A font parsed from a filename using the `Family-Weight[-Variant].ext` convention.
    struct ParsedFont: Sendable {
        /// The font family name.
        let family: String

        /// The resolved font weight.
        let weight: Font.Weight

        /// The font variant.
        let variant: Font.Variant
    }

    /// Copies custom font files from `Assets/Fonts`,
    /// parses font metadata from filenames, and registers fonts automatically.
    func copyUserFonts() {
        let fontsDirectory = assetsDirectory.appending(path: "Fonts")

        guard FileManager.default.fileExists(atPath: fontsDirectory.decodedPath) else {
            return
        }

        do {
            let fontFiles = try FileManager.default.contentsOfDirectory(
                at: fontsDirectory,
                includingPropertiesForKeys: nil
            )

            let buildFontsDirectory = buildDirectory.appending(path: "fonts")
            try FileManager.default.createDirectory(
                at: buildFontsDirectory,
                withIntermediateDirectories: true
            )

            var families: [String: [FontSource]] = [:]

            for fileURL in fontFiles {
                let normalizedFilename = fileURL.lastPathComponent.lowercased()
                let destination = buildFontsDirectory.appending(path: normalizedFilename)
                try FileManager.default.copyItem(at: fileURL, to: destination)

                guard let parsed = parseFontFilename(fileURL.lastPathComponent) else {
                    BuildContext.logWarning("""
                    Failed to auto-generate a @font-face rule for '\(fileURL.lastPathComponent)'. \
                    Font filenames must follow the pattern "Family-Weight[-Variant].ext" \
                    (e.g. "Inter-400Italic.woff2", "Inter-BoldItalic.ttf").
                    """)
                    continue
                }

                let webURL = URL(string: "/fonts/\(normalizedFilename)")!
                let source = FontSource(url: webURL, weight: parsed.weight, variant: parsed.variant)
                families[parsed.family, default: []].append(source)
            }

            for (family, sources) in families {
                BuildContext.register(Font(name: family, sources: sources))
            }

        } catch {
            fatalError(BuildError.failedToCopySiteResource("Fonts").description)
        }
    }

    /// Parses a font filename using the `Family-Weight[-Variant].ext` convention.
    func parseFontFilename(_ filename: String) -> ParsedFont? {
        let stem = filename.split(separator: ".").first.map(String.init) ?? ""

        let parts = stem.split(separator: "-", maxSplits: 1)
        let family = String(parts[0])
        let face = parts.count > 1 ? parts[1].lowercased() : "regular"

        let variant: Font.Variant = if face.contains("italic") {
            .italic
        } else if face.contains("oblique") {
            .oblique
        } else {
            .normal
        }

        let weightToken = face
            .replacingOccurrences(of: "italic", with: "")
            .replacingOccurrences(of: "oblique", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let weight = Font.Weight(filenameToken: weightToken) ?? .regular
        return ParsedFont(family: family, weight: weight, variant: variant)
    }

    /// Copies all non-font files from the project's "Assets" directory
    /// to the build output's root directory.
    func copyUserAssets() {
        guard FileManager.default.fileExists(atPath: assetsDirectory.decodedPath) else {
            return
        }

        do {
            let assets = try FileManager.default.contentsOfDirectory(
                at: assetsDirectory,
                includingPropertiesForKeys: [.isDirectoryKey]
            )

            for asset in assets {
                // Skip Fonts — handled separately
                if asset.lastPathComponent.lowercased() == "fonts" {
                    continue
                }

                let destination = buildDirectory.appending(path: asset.lastPathComponent)
                try FileManager.default.copyItem(at: asset, to: destination)
            }
        } catch {
            fatalError(BuildError.failedToCopySiteResource("Assets").description)
        }
    }

    /// Generates a robots.txt file for this site.
    package func generateRobots() {
        let generator = RobotsGenerator(site: site)
        let result = generator.generateRobots()

        do {
            let destinationURL = buildDirectory.appending(path: "robots.txt")
            try result.write(to: destinationURL, atomically: true, encoding: .utf8)
        } catch {
            BuildContext.logError(.failedToWriteFile("robots.txt"))
        }
    }

    /// Generates and writes the top-level sitemap index if multiple locales exist.
    /// - Returns: None. Writes directly to disk or logs an error if writing fails.
    package func generateSitemapIndex() {
        guard let indexXML = SiteMapGenerator.generateSitemapIndex(for: site) else { return }

        let indexURL = buildDirectory.appending(path: "sitemap.xml")
        do {
            try indexXML.write(to: indexURL, atomically: true, encoding: .utf8)
        } catch {
            BuildContext.logError(.failedToWriteFile("sitemap.xml"))
        }
    }

    /// Generates all CSS for the site — including themes, media queries, inline styles, and animations.
    /// Writes the combined result to `css/raptor-core.css`.
    package func write(_ css: String, to file: String) {
        let outputPath = buildDirectory.appending(path: "css/\(file)")

        do {
            let cssDirectory = outputPath.deletingLastPathComponent()
            try FileManager.default.createDirectory(
                at: cssDirectory,
                withIntermediateDirectories: true
            )

            let existing = (try? String(contentsOf: outputPath, encoding: .utf8)) ?? ""
            let combined = existing.isEmpty ? css : existing + "\n\n" + css
            try combined.write(to: outputPath, atomically: true, encoding: .utf8)

        } catch {
            BuildContext.logError(.failedToWriteFile("css/raptor-core.css"))
        }
    }
}

private extension Font.Weight {
    /// Creates a font weight from a filename token.
    /// - Parameter token: A case-insensitive weight token (for example,
    /// `"regular"`, `"bold"`, or `"semibold"`).
    /// - Returns: A matching `Font.Weight` if the token is recognized;
    /// otherwise `nil`.
    init?(filenameToken token: String) {
        switch token.lowercased() {
        case "ultralight", "100": self = .ultraLight
        case "thin", "200": self = .thin
        case "light", "300": self = .light
        case "regular", "normal", "400": self = .regular
        case "medium", "500": self = .medium
        case "semibold", "600": self = .semibold
        case "bold", "700": self = .bold
        case "heavy", "800": self = .heavy
        case "black", "900": self = .black
        default: return nil
        }
    }
}
