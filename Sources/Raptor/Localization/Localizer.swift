//
// Localizer.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// Provides localized strings for site packages by resolving
/// the correct resource bundle at publish time.
package enum Localizer {
    /// The bundle registered by the site (resolved once at publish time).
    nonisolated(unsafe) private static var registeredBundle: Bundle?

    /// The bundle used for all localization lookups.
    /// Defaults to `.main` if no site bundle is registered.
    private static var localizationBundle: Bundle {
        registeredBundle ?? .main
    }

    /// Registers the site’s resource bundle used for localization.
    private static func register(bundle: Bundle) {
        registeredBundle = bundle
    }

    /// Attempts to locate the site’s generated SwiftPM resource bundle
    /// (e.g., `MySite_MySite.bundle`) based on the calling file path.
    private static func detectSiteBundle(from file: StaticString) -> Bundle? {
        let fileURL = URL(fileURLWithPath: "\(file)")
        let fileDirectory = fileURL.deletingLastPathComponent()
        let targetDirectory = fileDirectory.deletingLastPathComponent()

        let targetName = targetDirectory.lastPathComponent
            // SwiftPM normalizes target names by removing spaces
            .replacingOccurrences(of: " ", with: "")
        let expectedBundleName = "\(targetName)_\(targetName).bundle"

        guard let execDirectory = Bundle.main.executableURL?
            .deletingLastPathComponent()
        else { return nil }

        let bundleURL = execDirectory.appendingPathComponent(expectedBundleName)
        return Bundle(url: bundleURL)
    }

    /// Automatically detects and registers the site’s bundle using its file path.
    /// Call from the site’s publish method.
    package static func autoRegister(from file: StaticString = #filePath) {
        if let bundle = detectSiteBundle(from: file) {
            register(bundle: bundle)
        } else {
            print("Localizer failed to locate a site bundle for \(file).")
        }
    }

    /// Returns a localized string for the given key, using the current or specified locale.
    /// - Parameters:
    ///   - key: The string key to look up in the localization table.
    ///   - locale: An optional locale identifier (e.g., `"fr"`, `"en_US"`). If `nil`, uses the current system locale.
    /// - Returns: The localized string if found, or the key itself if localization data is unavailable.
    package static func string(_ key: String, locale: Locale) -> String {
        let resource = LocalizedStringResource(
            String.LocalizationValue(stringLiteral: key),
            locale: locale,
            bundle: localizationBundle
        )
        return String(localized: resource)
    }
}
