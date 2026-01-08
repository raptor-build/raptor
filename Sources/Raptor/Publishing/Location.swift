//
// Location.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A location that can be written into our sitemap.
package struct Location: Sendable, Hashable, Equatable {
    var path: String
    var priority: Double

    package init(path: String, priority: Double) {
        self.path = path
        self.priority = priority
    }
}
