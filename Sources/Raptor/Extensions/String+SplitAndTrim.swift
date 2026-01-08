//
// String+SplitAndTrim.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

extension String {
    /// Splits a single string into an array of strings, breaking on commas, and
    /// automatically trimming whitespace.
    func splitAndTrim() -> [String] {
        self.split(separator: ",", omittingEmptySubsequences: true)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
}
