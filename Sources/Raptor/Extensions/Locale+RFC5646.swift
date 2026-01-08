//
// Locale+RFC5646.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

package extension Locale {
    /// Returns the RFC 5646–compliant language tag (e.g. `"en-US"` or `"fr"`).
    var asRFC5646: String {
        if let languageCode = language.languageCode?.identifier {
            if let regionCode = region?.identifier {
                return "\(languageCode)-\(regionCode)"
            }
            return languageCode
        }
        return identifier.replacingOccurrences(of: "_", with: "-")
    }
}
