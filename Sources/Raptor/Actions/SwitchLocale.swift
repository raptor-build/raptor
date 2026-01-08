//
// SwitchLocale.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// An action that switches the site’s active locale.
public struct SwitchLocale: Action {
    /// The locale to switch to.
    private let locale: Locale

    /// Creates a new locale-switching action.
    /// - Parameter locale: The locale to switch to (will be automatically normalized to RFC5646 format).
    public init(_ locale: Locale) {
        self.locale = locale
    }

    /// Compiles the action into JavaScript that calls the site’s locale-switching logic.
    /// - Returns: A JavaScript string that updates locale and navigates appropriately.
    public func compile() -> String {
        // Retrieve the full list of configured locales from the environment
        let siteLocales = RenderingContext.current?.environment.allLocales ?? []
        let defaultLocaleID = siteLocales.first?.asRFC5646.lowercased() ?? "en-us"

        // Normalize target locale identifier
        let localeID = locale.asRFC5646.lowercased()

        // Determine proper navigation path
        let targetPath: String
        if localeID == defaultLocaleID {
            targetPath = "/" // Default locale lives at the root
        } else {
            targetPath = "/\(localeID)/"
        }

        // Produce JavaScript that both sets locale and redirects
        return """
        setLocale('\(localeID)');
        window.location.href = '\(targetPath)';
        """
    }
}

public extension Action where Self == SwitchLocale {
    /// Creates a new `SwitchLocale` instance for a given locale.
    /// - Parameter locale: The locale to switch to.
    /// - Returns: A `SwitchLocale` configured with the specified locale.
    static func switchLocale(_ locale: Locale) -> Self {
        SwitchLocale(locale)
    }
}
