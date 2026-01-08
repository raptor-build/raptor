//
// GridTemplateAreas.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines named grid areas within a grid layout.
public struct GridTemplateAreas: Sendable, Hashable {
    /// The list of area names representing each row of the grid template.
    let areas: [String]

    /// Creates a new grid template from the specified rows.
    /// - Parameter rows: An array of strings where each string defines a row’s area names.
    public init(_ rows: [String]) {
        self.areas = rows
    }

    /// The CSS string representation of the grid template areas.
    var css: String {
        areas.map { "\"\($0)\"" }.joined(separator: " ")
    }
}
