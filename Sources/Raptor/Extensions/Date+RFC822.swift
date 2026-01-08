//
// Date+RFC822.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

extension Date {
    /// Converts the date to an RFC 822–formatted string for RSS feeds.
    /// - Parameter locale: The locale used for language and formatting.
    ///   The time zone is fixed to GMT for deterministic output.
    /// - Returns: An RFC 822–compliant date string.
    public func asRFC822(locale: Locale? = nil) -> String {
        let formatter = DateFormatter()

        // RFC-822 requires English, POSIX-safe formatting
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"

        return formatter.string(from: self)
    }
}
