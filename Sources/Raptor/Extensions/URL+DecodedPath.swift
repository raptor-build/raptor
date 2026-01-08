//
// URL+DecodedPath.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

extension URL {
    /// The URL path without percent encoding.
    var decodedPath: String {
        self.path(percentEncoded: false)
    }
}
