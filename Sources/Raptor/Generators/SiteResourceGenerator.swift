//
// SiteResourceGenerator.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

package struct SiteResourceGenerator {
    /// The site that is currently being built.
    let site: SiteContext

    /// An ordered set of syntax highlighters pulled from code blocks throughout the site.
    private var highlighterLanguages: OrderedSet<SyntaxHighlighterLanguage>

    /// Whether a fixed navigation bar adds padding to `<body>`.
    private var navigationReservesSpace: Bool

    /// Whether the current page includes a segmented control.
    private var includesSegmentedControl: Bool

    /// The directory containing their custom assets.
    var assetsDirectory: URL

    /// The directory containing their final, built website.
    package var buildDirectory: URL

    package init(
        rootDirectory: URL,
        buildDirectory: URL,
        buildContext: BuildContext,
        siteContext: SiteContext
    ) {
        self.site = siteContext
        self.buildDirectory = buildDirectory
        self.assetsDirectory = rootDirectory.appending(path: "Assets")
        self.highlighterLanguages = buildContext.syntaxHighlighterLanguages
        self.navigationReservesSpace = buildContext.navigationReservesSpace
        self.includesSegmentedControl = buildContext.includesSegmentedControl
    }

    /// Copies the key resources for building: user assets, JavaScript
    /// and CSS, fonts if enabled, and syntax highlighters
    /// if enabled.
    package func copyResources() {
        copyUserAssets()
        copyUserFonts()
        copyCoreCSS()
        copyOptionalCSS()
        copyCoreJS()
        copyUnbundledJS()

        copyResource(at: "css/icons/bootstrap-icons.min.css", to: "css")
        copyResource("fonts/bootstrap-icons.woff")
        copyResource("fonts/bootstrap-icons.woff2")

        if site.isSearchEnabled {
            copyResource(at: "js/lunr/lunr.js", to: "js")
            copyResource(at: "js/raptor-unbundled/raptor-search.js", to: "js")
        }

        if includesSegmentedControl {
            copyResource(at: "js/raptor-unbundled/raptor-segmented-controls.js", to: "js")
        }

        if navigationReservesSpace {
            copyResource(at: "js/raptor-unbundled/raptor-nav-reserved-space.js", to: "js")
        }

        if highlighterLanguages.isEmpty == false {
            copyPrismCSS()
            copyPrismJS()
        }
    }

    /// Calculates the full list of syntax highlighters need by this site, including
    /// resolving dependencies.
    private func copyPrismJS() {
        let generator = SyntaxHighlightGenerator(highlighters: highlighterLanguages)
        let result = generator.generateSyntaxHighlighters()

        do {
            let destinationURL = buildDirectory.appending(path: "js/prism.js")
            try result.write(to: destinationURL, atomically: true, encoding: .utf8)
        } catch {
            fatalError(BuildError.failedToWriteSyntaxHighlighters.description)
        }
    }

    private func copyPrismCSS() {
        let fileManager = FileManager.default

        // Locate the prism resource directory
        guard let prismDirectoryURL = Bundle.module.url(
            forResource: "Resources/css/prism",
            withExtension: nil
        ) else {
            fatalError("Failed to locate Resources/css/prism in bundle.")
        }

        // Enumerate all files in the prism directory
        guard let cssFiles = try? fileManager.contentsOfDirectory(
            at: prismDirectoryURL,
            includingPropertiesForKeys: nil,
            options: [.skipsHiddenFiles]
        ) else {
            fatalError("Failed to read contents of Resources/css/prism.")
        }

        var combinedCSS = ""

        for fileURL in cssFiles {
            do {
                let contents = try String(contentsOf: fileURL, encoding: .utf8)
                combinedCSS += contents
                combinedCSS += "\n\n"
            } catch {
                let path = "css/prism/\(fileURL.lastPathComponent)"
                fatalError(BuildError.failedToCopySiteResource(path).description
                )
            }
        }

        let destinationDirectory = buildDirectory.appending(path: "css")
        let destinationFile = destinationDirectory.appending(path: "prism.css")

        do {
            try fileManager.createDirectory(at: destinationDirectory, withIntermediateDirectories: true)
            try combinedCSS.write(to: destinationFile, atomically: true, encoding: .utf8)
        } catch {
            fatalError(BuildError.failedToWriteFile("css/prism.css").description)
        }
    }

    private func copyCoreJS() {
        guard let jsFolder = Bundle.module.url(forResource: "Resources/js", withExtension: nil) else {
            fatalError(BuildError.missingSiteResource("js/raptor-core").description)
        }

        let raptorCorePath = buildDirectory.appending(path: "js/raptor-core.js")

        do {
            let jsFiles = try FileManager.default
                .contentsOfDirectory(at: jsFolder, includingPropertiesForKeys: nil)
                .filter { !$0.hasDirectoryPath }

            var combinedJS = ""

            for jsFile in jsFiles {
                let contents = try String(contentsOf: jsFile, encoding: .utf8)
                combinedJS += contents + "\n\n"
            }

            let buildJSDirectory = buildDirectory.appending(path: "js")
            try FileManager.default.createDirectory(
                at: buildJSDirectory,
                withIntermediateDirectories: true)

            try combinedJS.write(
                to: raptorCorePath,
                atomically: true,
                encoding: .utf8)
        } catch {
            fatalError(BuildError.failedToCopySiteResource("js").description)
        }
    }

    private func copyUnbundledJS() {
        guard let unbundledJSFolder = Bundle.module.url(
            forResource: "Resources/js/raptor-unbundled",
            withExtension: nil
        ) else {
            fatalError(BuildError.missingSiteResource("js/raptor-unbundled").description)
        }

        let buildJSDirectory = buildDirectory.appending(path: "js")

        do {
            let jsFiles = try FileManager.default
                .contentsOfDirectory(at: unbundledJSFolder, includingPropertiesForKeys: nil)
                .filter { !$0.hasDirectoryPath }

            try FileManager.default.createDirectory(
                at: buildJSDirectory,
                withIntermediateDirectories: true)

            for jsFile in jsFiles {
                let destinationURL = buildJSDirectory.appending(path: jsFile.lastPathComponent)

                let contents = try String(contentsOf: jsFile, encoding: .utf8)
                try contents.write(
                    to: destinationURL,
                    atomically: true,
                    encoding: .utf8)
            }
        } catch {
            fatalError(BuildError.failedToCopySiteResource("raptor-unbundled").description)
        }
    }

    private func copyCoreCSS() {
        guard let cssFolder = Bundle.module.url(
            forResource: "Resources/css/raptor-core",
            withExtension: nil
        ) else {
            fatalError(BuildError.missingSiteResource("css/raptor-core").description)
        }

        let outputPath = buildDirectory.appending(path: "css/raptor-core.css")

        do {
            let cssFiles = try FileManager.default
                .contentsOfDirectory(at: cssFolder, includingPropertiesForKeys: nil)
                .filter { !$0.hasDirectoryPath }

            var combinedCSS = ""

            // Must be first, in this order
            let criticalFiles = [
                "raptor-core-variables.css",
                "raptor-core-reset.css"
            ]

            for filename in criticalFiles {
                let fileURL = cssFolder.appending(path: filename)
                let content = try String(contentsOf: fileURL, encoding: .utf8)
                combinedCSS += content + "\n\n"
            }

            // Remaining core CSS, alphabetically
            let remainingFiles = cssFiles
                .filter { !criticalFiles.contains($0.lastPathComponent) }
                .sorted { $0.lastPathComponent < $1.lastPathComponent }

            for file in remainingFiles {
                let content = try String(contentsOf: file, encoding: .utf8)
                combinedCSS += content + "\n\n"
            }

            let buildCSSDirectory = outputPath.deletingLastPathComponent()
            try FileManager.default.createDirectory(
                at: buildCSSDirectory,
                withIntermediateDirectories: true)

            try combinedCSS.write(
                to: outputPath,
                atomically: true,
                encoding: .utf8)
        } catch {
            fatalError(BuildError.failedToCopySiteResource("css/raptor-core.css").description)
        }
    }

    private func copyOptionalCSS() {
        guard let cssFolder = Bundle.module.url(
            forResource: "Resources/css",
            withExtension: nil
        ) else {
            fatalError(BuildError.missingSiteResource("css").description)
        }

        let outputPath = buildDirectory.appending(path: "css/raptor-core.css")

        do {
            let cssFiles = try FileManager.default
                .contentsOfDirectory(at: cssFolder, includingPropertiesForKeys: nil)
                .filter { !$0.hasDirectoryPath }

            var combinedCSS = ""

            for file in cssFiles {
                let content = try String(contentsOf: file, encoding: .utf8)
                combinedCSS += content + "\n\n"
            }

            let buildCSSDirectory = outputPath.deletingLastPathComponent()
            try FileManager.default.createDirectory(
                at: buildCSSDirectory,
                withIntermediateDirectories: true)

            let existing = try String(contentsOf: outputPath, encoding: .utf8)
            try (existing + combinedCSS).write(
                to: outputPath,
                atomically: true,
                encoding: .utf8)
        } catch {
            fatalError(BuildError.failedToCopySiteResource("css/raptor-core.css").description)
        }
    }

    /// Copies one file from the Raptor resources into the final build folder.
    /// - Parameters resource: The resource to copy.
    private func copyResource(_ resource: String) {
        guard let sourceURL = Bundle.module.url(forResource: "Resources/\(resource)", withExtension: nil) else {
            fatalError(BuildError.missingSiteResource(resource).description)
        }

        let filename = sourceURL.lastPathComponent
        let destination = sourceURL.deletingLastPathComponent().lastPathComponent

        let destinationDirectory = buildDirectory.appending(path: destination)
        let destinationFile = destinationDirectory.appending(path: filename)

        do {
            try FileManager.default.createDirectory(at: destinationDirectory, withIntermediateDirectories: true)
            try FileManager.default.copyItem(at: sourceURL, to: destinationFile)
        } catch {
            fatalError(BuildError.failedToCopySiteResource(resource).description)
        }
    }

    /// Copies a bundled resource into a fixed output directory, ignoring its source folders.
    private func copyResource(at sourceDirectory: String, to outputDirectory: String) {
        guard let sourceURL = Bundle.module.url(
            forResource: "Resources/\(sourceDirectory)",
            withExtension: nil
        ) else {
            fatalError(BuildError.missingSiteResource(sourceDirectory).description)
        }

        let destinationDirectory = buildDirectory.appending(path: outputDirectory)
        let destinationFile = destinationDirectory.appending(path: sourceURL.lastPathComponent)

        do {
            try FileManager.default.createDirectory(at: destinationDirectory, withIntermediateDirectories: true)

            if FileManager.default.fileExists(atPath: destinationFile.path) {
                return
            }

            try FileManager.default.copyItem(at: sourceURL, to: destinationFile)
        } catch {
            fatalError(BuildError.failedToCopySiteResource(sourceDirectory).description)
        }
    }
}
