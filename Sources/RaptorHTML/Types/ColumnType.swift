//
// ColumnType.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Shorthand for combining `column-width` and `column-count`.
public struct ColumnType: CustomStringConvertible, Sendable {
    var width: LengthUnit?
    var count: Int?

    init(width: LengthUnit? = nil, count: Int? = nil) {
        self.width = width
        self.count = count
    }

    public var description: String {
        switch (width, count) {
        case let (.some(width), .some(count)):
            "\(width.description) \(count)"
        case let (.some(width), .none):
            width.description
        case let (.none, .some(count)):
            "\(count)"
        case (.none, .none):
            "auto"
        }
    }
}
