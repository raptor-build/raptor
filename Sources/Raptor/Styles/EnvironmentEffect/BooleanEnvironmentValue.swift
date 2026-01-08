//
// BooleanEnvironmentBranch.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Defines a boolean environment dimension with explicit true and false cases.
///
/// Conforming types map a conceptual boolean value to the concrete
/// environment conditions that activate each branch.
protocol BooleanEnvironmentValue {
    /// The condition that represents the `true` branch.
    var `true`: BooleanEnvironmentCondition { get }

    /// The condition that represents the `false` branch.
    var `false`: BooleanEnvironmentCondition { get }
}
