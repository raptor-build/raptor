//
// String+TruncatedHash.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

extension String {
    /// Creates a 5-character hash string that remains consistent across app launches.
    ///
    /// This method converts the string into a compact alphanumeric hash (e.g., `"Hello World"` → `"5eb21"`),
    /// suitable for generating stable, human-readable identifiers such as CSS class suffixes.
    var truncatedHash: String {
        let hash = strHash(self)

        // Deterministic alphanumeric character set (0–9, A–Z, a–z)
        let charset = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
        var result = ""
        var remainingHash = hash

        // Generate exactly five characters for a compact, consistent identifier
        for _ in 0..<5 {
            let index = Int(remainingHash % UInt64(charset.count))
            result.append(charset[index])
            remainingHash /= UInt64(charset.count)
        }

        return result
    }

    /// Computes a deterministic 64-bit hash for a given string using a custom algorithm.
    /// - Parameter str: The input string to hash.
    /// - Returns: A 64-bit unsigned integer representing the deterministic hash.
    private func strHash(_ str: String) -> UInt64 {
        var result = UInt64(5381)
        let characters = [UInt8](str.utf8)

        for character in characters {
            result = 127 * (result & 0x00ffffffffffffff) + UInt64(character)
        }

        return result
    }
}
