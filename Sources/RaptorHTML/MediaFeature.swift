//
// MediaFeature.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// An internal type used to represent true media query features during CSS
/// generation, as not all types that conform to `Query` are valid features.
package protocol MediaFeature: CustomStringConvertible, Sendable {
    var condition: String { get }
}

extension MediaFeature {
    public var description: String { condition }
}
