//
// Language.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// Static, typed accessors for the most common RFC 5646-compliant locales.
public extension Locale {
    static var automatic: Self { .english }

    // MARK: - African Languages
    static let afrikaans = Locale(identifier: "af")
    static let amharic = Locale(identifier: "am")
    static let arabic = Locale(identifier: "ar")
    static let arabicEgypt = Locale(identifier: "ar-EG")
    static let arabicSaudiArabia = Locale(identifier: "ar-SA")
    static let swahili = Locale(identifier: "sw")
    static let xhosa = Locale(identifier: "xh")
    static let yoruba = Locale(identifier: "yo")
    static let zulu = Locale(identifier: "zu")

    // MARK: - Asian Languages
    static let bengali = Locale(identifier: "bn")
    static let chinese = Locale(identifier: "zh")
    static let chineseSimplified = Locale(identifier: "zh-CN")
    static let chineseTraditional = Locale(identifier: "zh-TW")
    static let hindi = Locale(identifier: "hi")
    static let indonesian = Locale(identifier: "id")
    static let japanese = Locale(identifier: "ja")
    static let korean = Locale(identifier: "ko")
    static let malay = Locale(identifier: "ms")
    static let thai = Locale(identifier: "th")
    static let vietnamese = Locale(identifier: "vi")

    // MARK: - European Languages
    static let albanian = Locale(identifier: "sq")
    static let basque = Locale(identifier: "eu")
    static let bosnian = Locale(identifier: "bs")
    static let bulgarian = Locale(identifier: "bg")
    static let catalan = Locale(identifier: "ca")
    static let croatian = Locale(identifier: "hr")
    static let czech = Locale(identifier: "cs")
    static let danish = Locale(identifier: "da")
    static let dutch = Locale(identifier: "nl")
    static let dutchNetherlands = Locale(identifier: "nl-NL")
    static let english = Locale(identifier: "en")
    static let englishUnitedStates = Locale(identifier: "en-US")
    static let englishUnitedKingdom = Locale(identifier: "en-GB")
    static let englishCanada = Locale(identifier: "en-CA")
    static let englishAustralia = Locale(identifier: "en-AU")
    static let finnish = Locale(identifier: "fi")
    static let french = Locale(identifier: "fr")
    static let frenchFrance = Locale(identifier: "fr-FR")
    static let frenchCanada = Locale(identifier: "fr-CA")
    static let german = Locale(identifier: "de")
    static let germanGermany = Locale(identifier: "de-DE")
    static let germanSwitzerland = Locale(identifier: "de-CH")
    static let greek = Locale(identifier: "el")
    static let hungarian = Locale(identifier: "hu")
    static let icelandic = Locale(identifier: "is")
    static let irish = Locale(identifier: "ga")
    static let italian = Locale(identifier: "it")
    static let italianItaly = Locale(identifier: "it-IT")
    static let italianSwitzerland = Locale(identifier: "it-CH")
    static let latvian = Locale(identifier: "lv")
    static let lithuanian = Locale(identifier: "lt")
    static let maltese = Locale(identifier: "mt")
    static let norwegian = Locale(identifier: "no")
    static let norwegianBokmal = Locale(identifier: "nb")
    static let norwegianNynorsk = Locale(identifier: "nn")
    static let polish = Locale(identifier: "pl")
    static let portuguese = Locale(identifier: "pt")
    static let portugueseBrazil = Locale(identifier: "pt-BR")
    static let portuguesePortugal = Locale(identifier: "pt-PT")
    static let romanian = Locale(identifier: "ro")
    static let russian = Locale(identifier: "ru")
    static let serbian = Locale(identifier: "sr")
    static let slovak = Locale(identifier: "sk")
    static let slovene = Locale(identifier: "sl")
    static let spanish = Locale(identifier: "es")
    static let spanishSpain = Locale(identifier: "es-ES")
    static let spanishMexico = Locale(identifier: "es-MX")
    static let swedish = Locale(identifier: "sv")
    static let swedishSweden = Locale(identifier: "sv-SE")
    static let turkish = Locale(identifier: "tr")
    static let ukrainian = Locale(identifier: "uk")

    // MARK: - Middle Eastern Languages
    static let hebrew = Locale(identifier: "he")
    static let persian = Locale(identifier: "fa")
    static let kurdish = Locale(identifier: "ku")
    static let pashto = Locale(identifier: "ps")
    static let urdu = Locale(identifier: "ur")

    // MARK: - Pacific and Others
    static let filipino = Locale(identifier: "tl")
    static let samoan = Locale(identifier: "sm")
    static let maori = Locale(identifier: "mi")
    static let tahitian = Locale(identifier: "ty")
    static let hawaiian = Locale(identifier: "haw") // unofficial but common
}

extension Locale {
    /// Returns whether this locale is the default locale of the current site.
    func isDefault(for site: SiteContext) -> Bool {
        guard let defaultLocale = site.locales.first else { return false }
        return self.asRFC5646.lowercased() == defaultLocale.asRFC5646.lowercased()
    }

    /// Returns the localized home path for this locale, relative to the site root.
    /// Example:
    /// - Default locale: returns `/`
    /// - Non-default locale: returns `/it/`
    func homePath(for site: SiteContext) -> String {
        let localeCode = asRFC5646.lowercased()
        let isDefault = self.isDefault(for: site)
        return isDefault ? "/" : "/\(localeCode)/"
    }

}

public extension Locale {
    /// Returns a human-readable, localized name for the locale (e.g. “United States English” or “French (France)”).
    ///
    /// If the system cannot determine a localized name, it falls back to the locale identifier (e.g. `"en-US"`).
    var displayName: String {
        guard let context = RenderingContext.current else {
            fatalError("Locale/displayName accessed outside of a rendering context.")
        }

        let systemLocale = context.locale
        return systemLocale.localizedString(forIdentifier: identifier) ?? identifier
    }
}
