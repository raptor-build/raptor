//
// MetaLinkConfiguration.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A configuration object used when constructing a `<link>` element.
///
/// Use this type with the `link(_:relationship:configure:)` modifier to
/// customize how the link loads, such as specifying `crossorigin`,
/// `as`, `type`, integrity hashes, or data attributes.
public struct MetaLinkConfiguration: Sendable {
    /// The resource URL to load.
    var href: String

    /// The relationship between the resource and the current document.
    var relationship: LinkRelationship

    /// Additional custom attributes to apply to the generated `<link>` element.
    var attributes = CoreAttributes()

    /// Creates a configuration for a `<link>` element.
    /// - Parameters:
    ///   - href: The resource URL to load.
    ///   - relationship: How the linked resource relates to this page.
    init(href: String, relationship: LinkRelationship) {
        self.href = href
        self.relationship = relationship
    }
}

public extension MetaLinkConfiguration {
    /// Declares the kind of resource being preloaded.
    ///
    /// Browsers use this information to apply the correct loading
    /// behavior and security restrictions for the resource.
    ///
    /// - Parameter type: The resource kind, such as `"font"` or `"image"`.
    /// - Returns: An updated configuration.
    func resourceType(_ type: ResourceType) -> Self {
        var copy = self
        copy.attributes.append(customAttributes: .init(name: "as", value: type.rawValue))
        return copy
    }

    /// Specifies the MIME type of the linked resource.
    ///
    /// This helps browsers interpret the resource correctly, and is required
    /// for some preloaded asset types (such as fonts).
    ///
    /// - Parameter mime: The MIME type, such as `"font/woff2"`.
    /// - Returns: An updated configuration.
    func mimeType(_ mime: MIMEType) -> Self {
        var copy = self
        copy.attributes.append(customAttributes: .init(name: "type", value: mime.value))
        return copy
    }

    /// Sets the crossorigin behavior for the linked resource.
    ///
    /// This determines whether credentials may be sent when the resource
    /// is fetched.
    ///
    /// - Parameter mode: How cross-origin requests should behave.
    /// - Returns: An updated configuration.
    func crossOrigin(_ mode: CrossOrigin) -> Self {
        var copy = self
        copy.attributes.append(customAttributes: .init(
            name: "crossorigin", value: mode.rawValue
        ))
        return copy
    }

    /// Adds a custom attribute to the `<link>` element.
    ///
    /// Use this for uncommon link attributes that are not provided
    /// by Raptor’s convenience methods.
    ///
    /// - Parameters:
    ///   - name: The attribute name.
    ///   - value: The attribute value.
    /// - Returns: A modified configuration.
    func attribute(_ name: String, _ value: String) -> Self {
        var copy = self
        copy.attributes.append(customAttributes: .init(name: name, value: value))
        return copy
    }
}

public enum ResourceType: String, Sendable {
    case audio
    case audioWorklet = "audioworklet"
    case document
    case embed
    case font
    case fetch
    case iframe
    case image
    case manifest
    case object
    case paintWorklet = "paintworklet"
    case script
    case serviceWorker = "serviceworker"
    case sharedWorker = "sharedworker"
    case style
    case track
    case video
    case worker
    case xslt
}

public enum MIMEType: Sendable {
    case css
    case woff2
    case woff
    case ttf
    case svg
    case png
    case jpeg
    case webp
    case custom(String)

    public var value: String {
        switch self {
        case .css: return "text/css"
        case .woff2: return "font/woff2"
        case .woff: return "font/woff"
        case .ttf: return "application/font-sfnt"
        case .svg: return "image/svg+xml"
        case .png: return "image/png"
        case .jpeg: return "image/jpeg"
        case .webp: return "image/webp"
        case let .custom(string): return string
        }
    }
}
