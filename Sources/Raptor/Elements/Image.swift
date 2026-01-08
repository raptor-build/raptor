//
// Image.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// An image on your page. Can be vector (SVG) or raster (JPG, PNG, GIF).
public struct Image: InlineContent, LazyLoadable {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The path of the image, either relative to the
    /// root of your site, e.g. /images/dog.jpg., or as a web address.
    private var path: URL?

    /// Loads an image from one of the built-in icons. See
    /// https://icons.getbootstrap.com for the list.
    private var systemImage: String?

    /// An accessibility label for this image, suitable for screen readers.
    private var description: String?

    /// Creates a new `Image` instance from the specified path. For an image contained
    /// in your site's assets, this should be specified relative to the root of your
    /// site, e.g. /images/dog.jpg.
    /// - Parameters:
    ///   - name: The filename of your image relative to the root of your site.
    ///   e.g. /images/welcome.jpg.
    ///   - description: An description of your image suitable for screen readers.
    public init(_ path: String, description: String? = nil) {
        self.path = URL(string: path)
        self.description = description
    }

    /// Creates a new `Image` instance from the name of one of the built-in
    /// icons. See https://icons.getbootstrap.com for the list.
    /// - Parameters:
    ///   - systemName: An image name chosen from https://icons.getbootstrap.com
    ///   - description: An description of your image suitable for screen readers.
    public init(systemName: String, description: String? = nil) {
        self.systemImage = systemName
        self.description = description
    }

    /// Creates a new decorative `Image` instance from the name of an
    /// image contained in your site's assets folder. Decorative images are hidden
    /// from screen readers.
    /// - Parameter name: The filename of your image relative to the root
    /// of your site, e.g. /images/dog.jpg.
    public init(decorative name: String) {
        self.path = URL(string: name)
        self.description = ""
        self.attributes.append(customAttributes: .init(name: "role", value: "presentation"))
    }

    /// Allows this image to be scaled up or down from its natural size in
    /// order to fit into its container.
    /// - Returns: A new `Image` instance configured to be flexibly sized.
    public func resizable() -> Self {
        var copy = self
        copy.attributes.append(classes: "img-resizable")
        return copy
    }

    /// Sets the accessibility label for this image to a string suitable for
    /// screen readers.
    /// - Parameter label: The new accessibility label to use.
    /// - Returns: A new `Image` instance with the updated accessibility label.
    public func accessibilityLabel(_ label: String) -> Self {
        var copy = self
        copy.description = label
        return copy
    }

    /// Renders a system image into HTML.
    /// - Parameter icon: The system image to render.
    /// - Returns: The HTML for this element.
    private func render(icon: String) -> Markup {
        var attributes = attributes
        attributes.append(customAttributes: .init(name: "alt", value: icon))
        attributes.append(classes: "bi-\(icon)")
        return Markup("<i\(attributes)></i>")
    }

    /// Renders a user image into HTML.
    /// - Parameters:
    ///   - path: The user image to render.
    ///   - description: The accessibility label to use.
    /// - Returns: The HTML for this element.
    private func render(path: String, description: String) -> Markup {
        var attributes = attributes
        attributes.append(customAttributes:
            .init(name: "src", value: path),
            .init(name: "alt", value: description))

        let (lightVariants, darkVariants) = findVariants(for: path)

        if let sourceSet = generateSourceSet(lightVariants) {
            attributes.append(customAttributes: sourceSet)
        }

        if darkVariants.isEmpty {
            return Markup("<img\(attributes) />")
        }

        var output = "<picture\(attributes)>"

        if let darkSourceSet = generateSourceSet(darkVariants), let value = darkSourceSet.value {
            output += "<source media=\"(prefers-color-scheme: dark)\" srcset=\"\(value)\">"
        }

        // Add the fallback img tag
        output += "<img\(attributes) />"
        output += "</picture>"
        return Markup(output)
    }

    /// Loads an SVG asset and inlines its markup so it can be styled using CSS.
    /// - Parameter path: The resolved web path to the SVG asset.
    /// - Returns: A `Markup` value containing the inlined SVG, or empty markup if loading fails.
    private func renderSVG(at path: String) -> Markup {
        let assetURL = renderingContext.assetsDirectory
            .appendingPathComponent(path.trimmingCharacters(in: CharacterSet(charactersIn: "/")))

        guard var svg = try? String(contentsOf: assetURL, encoding: .utf8) else {
            BuildContext.logWarning("Failed to load SVG at \(path)")
            return Markup()
        }

        // Find the opening <svg ...> tag
        guard let range = svg.range(of: "<svg[^>]*>", options: .regularExpression) else {
            BuildContext.logWarning("Invalid SVG format at \(path)")
            return Markup()
        }

        // Build merged attributes
        var mergedAttributes = attributes
        mergedAttributes.append(classes: "svg")

        // Inject attributes just before the closing ">"
        let openingTag = svg[range]
        let updatedTag = openingTag.dropLast() + "\(mergedAttributes)>"

        svg.replaceSubrange(range, with: updatedTag)

        return Markup(svg)
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        if let systemImage {
            return render(icon: systemImage)
        } else if let path {
            if description == nil {
                BuildContext.logWarning("""
                \(path.relativePath): adding images without a description is not recommended. \
                Provide a description or use Image(decorative:) to silence this warning.
                """)
            }
            let resolvedPath = renderingContext.path(for: path)

            if resolvedPath.lowercased().hasSuffix(".svg") {
                return renderSVG(at: resolvedPath)
            }

            return render(path: resolvedPath, description: description ?? "")
        } else {
            BuildContext.logWarning("""
            Creating an image with no name or icon should not be possible. \
            Please file a bug report on the Raptor project.
            """)
            return Markup()
        }
    }
}

private extension Image {
    /// Checks if a filename contains a pixel density descriptor (e.g., "@2x").
    func isDensityVariant(_ name: String) -> Bool {
        let densityPattern = /.*@\d+x.*/
        return name.contains(densityPattern)
    }

    /// Extracts the pixel density descriptor from a filename (e.g., "2x" from "image@2x.jpg").
    func getDensityDescriptor(_ name: String) -> String? {
        let densityPattern = /@(\d+)x/
        guard let match = name.firstMatch(of: densityPattern) else { return nil }
        return "\(match.output.1)x"
    }

    /// Locates image variants with appearance modifiers (`~dark`) and scale modifiers (`@2x`),
    /// supporting combined modifiers like `@2x~dark`.
    /// - Parameter path: The path to the original image file
    /// - Returns: A tuple containing arrays of URLs for light and dark variants
    func findVariants(for path: String) -> (light: [URL], dark: [URL]) {
        let url = URL(fileURLWithPath: path)
        let assetPath = renderingContext.assetsDirectory.appendingPathComponent(url.deletingLastPathComponent().path)
        let pathExtension = url.pathExtension

        let baseImageName = url.deletingPathExtension().lastPathComponent
            .split(separator: "~").first?
            .split(separator: "@").first ?? ""

        guard let files = try? FileManager.default.contentsOfDirectory(at: assetPath, includingPropertiesForKeys: nil)
            .filter({ $0.pathExtension == pathExtension })
        else {
            BuildContext.logWarning("Could not read the assets directory. Please file a bug report.")
            return ([], [])
        }

        return files.reduce(into: ([URL](), [URL]())) { result, file in
            let filename = file.deletingPathExtension().lastPathComponent
            let baseFilename = filename.split(separator: "~").first?.split(separator: "@").first ?? ""
            guard baseFilename.localizedCaseInsensitiveCompare(baseImageName) == .orderedSame else { return }

            if filename.localizedCaseInsensitiveContains("~dark") {
                result.1.append(file)
            } else if filename.localizedCaseInsensitiveContains("~light") || isDensityVariant(filename) {
                result.0.append(file)
            }
        }
    }

    /// Creates a `srcset` string from image variants with their corresponding pixel density descriptors,
    /// e.g., `"/images/hero@2x.jpg 2x"`
    /// - Parameter variants: An array of image variant URLs
    /// - Returns: An HTML attribute containing the srcset value, or nil if no valid variants exist
    func generateSourceSet(_ variants: [URL]) -> Attribute? {
        let assetsDirectory = renderingContext.assetsDirectory

        let sources = variants.compactMap { variant in
            let filename = variant.deletingPathExtension().lastPathComponent
            let densityDescriptor = getDensityDescriptor(filename).map { " \($0)" } ?? ""
            let relativePath = variant.path.replacingOccurrences(of: assetsDirectory.path, with: "")
            let webPath = relativePath.split(separator: "/").joined(separator: "/")
            return "/\(webPath)\(densityDescriptor)"
        }.joined(separator: ", ")

        return sources.isEmpty ? nil : .init(name: "srcset", value: sources)
    }
}
