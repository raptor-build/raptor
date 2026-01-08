//
// DynamicValues.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A type that defines how a value adapts across three horizontal size classes.
///
/// `DynamicValues` lets you specify different values for compact, regular, and expanded
/// size classes. Values inherit from smaller size classes when not explicitly provided,
/// allowing authors to define only what they need.
///
/// The `compact` value acts as the base. If `regular` or `expanded` values are omitted,
/// they fall back to the nearest smaller size class with a defined value.
/// This creates a natural, cascading behavior from compact → regular → expanded.
struct DynamicValues<Value>: Hashable, Equatable, Sendable
where Value: Equatable & Hashable & Sendable {
    private let compact: Value?
    private let regular: Value
    private let expanded: Value?

    /// Creates adaptive values for three horizontal size classes.
    /// - Parameters:
    ///   - compact: The value used for compact size classes (smallest screens).
    ///   - regular: The value used for regular size classes (default for most layouts).
    ///   - expanded: The value used for expanded size classes (large and wide screens).
    init(
        compact: Value? = nil,
        regular: Value,
        expanded: Value? = nil
    ) {
        self.compact = compact
        self.regular = regular
        self.expanded = expanded
    }

    /// Returns the adaptive values with cascading behavior applied.
    ///
    /// - Returns: A dictionary mapping size classes to their effective values.
    var values: [HorizontalSizeClass: Value] {
        resolve(cascaded: true)
    }

    /// Returns the adaptive values, optionally disabling cascading behavior.
    /// - Parameter cascaded: Whether missing values should inherit from smaller size classes.
    /// - Returns: A dictionary mapping size classes to their values.
    func values(cascaded: Bool) -> [HorizontalSizeClass: Value] {
        resolve(cascaded: cascaded)
    }

    /// Applies cascading rules and resolves the final values for each size class.
    private func resolve(cascaded: Bool) -> [HorizontalSizeClass: Value] {
        let raw: [(HorizontalSizeClass, Value?)] = [
            (.compact, compact),
            (.regular, regular),
            (.expanded, expanded)
        ]

        if !cascaded {
            return Dictionary(
                uniqueKeysWithValues: raw.compactMap { sizeClass, value in
                    value.map { (sizeClass, $0) }
                }
            )
        }

        var result: [HorizontalSizeClass: Value] = [:]
        var last: Value?

        for (sizeClass, value) in raw {
            if let value {
                result[sizeClass] = value
                last = value
            } else if let inherited = last {
                result[sizeClass] = inherited
            }
        }

        return result
    }
}

extension DynamicValues where Value == LengthUnit {
    func expandedForBreakpoints() -> [Breakpoint: LengthUnit] {
        let compactValue  = compact ?? regular
        let regularValue  = regular
        let expandedValue = expanded ?? regular

        return [
            .xSmall: compactValue,
            .small: compactValue,
            .medium: regularValue,
            .large: regularValue,
            .xLarge: expandedValue
        ]
    }
}
