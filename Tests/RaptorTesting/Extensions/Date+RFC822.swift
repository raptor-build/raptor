//
//  Date+RFC822.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Date.asRFC822(locale:)` extension.
///
/// These tests validate RFC-822 formatting with a fixed GMT time zone.
/// Locale is accepted for API consistency but does not affect the
/// numeric time-zone offset, which is always `+0000`.
///
/// NOTE:
/// Tests only use dates after the Unix epoch (Jan 1, 1970) to avoid
/// historical calendar and time-zone edge cases.
@Suite("Date+RFC822 Tests")
struct DateRFC822Tests {
    private struct Instance {
        let input: Date
        let expected: String
    }

    /// Known RFC-822 outputs in GMT (`+0000`)
    private static let gmtCases: [Instance] = [
        Instance(
            input: Date(timeIntervalSince1970: 20012346618.957466),
            expected: "Fri, 02 Mar 2604 09:10:18 +0000"),
        Instance(
            input: Date(timeIntervalSince1970: 56076958399.89086),
            expected: "Tue, 03 Jan 3747 20:53:19 +0000"),
        Instance(
            input: Date(timeIntervalSince1970: 43889947931.30432),
            expected: "Sat, 25 Oct 3360 12:12:11 +0000"),
        Instance(
            input: Date(timeIntervalSince1970: 60401587537.13003),
            expected: "Sat, 19 Jan 3884 10:45:37 +0000"),
        Instance(
            input: Date(timeIntervalSince1970: 2887257381.52073),
            expected: "Wed, 29 Jun 2061 07:56:21 +0000")
    ]

    @Test("Produces expected RFC-822 output in GMT", arguments: gmtCases)
    private func outputs_expected_result_in_gmt(instance: Instance) {
        let locale = Locale(identifier: "en_US_POSIX")
        #expect(instance.input.asRFC822(locale: locale) == instance.expected)
    }

    @Test("RFC-822 output is deterministic across locales", arguments: gmtCases)
    private func output_is_identical_across_locales(instance: Instance) {
        let locales: [Locale] = [
            Locale(identifier: "en_US_POSIX"),
            Locale(identifier: "en_US"),
            Locale(identifier: "en_GB"),
            Locale(identifier: "fr_FR"),
            Locale(identifier: "ja_JP")
        ]

        let outputs = locales.map {
            instance.input.asRFC822(locale: $0)
        }

        let first = outputs.first!
        for output in outputs {
            #expect(output == first)
        }
    }

    @Test("RFC-822 output matches required format")
    private func output_matches_rfc822_format() {
        let date = Date(timeIntervalSince1970: 1700000000)
        let output = date.asRFC822(locale: Locale(identifier: "en_US_POSIX"))

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"

        #expect(formatter.date(from: output) != nil)
    }
}
