//
// Date+ISO8601.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

extension Date {
    /// Converts `Date` objects to ISO 8601 format.
    public var asISO8601: String {
        let formatter = ISO8601DateFormatter()
        return formatter.string(from: self)
    }
}
