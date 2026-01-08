//
// Amount.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public enum Amount<Exact: Sendable, Semantic: Sendable>: Sendable {
    /// An exact value in pixels.
    case exact(Exact)

    /// A semantic value that adapts based on context.
    case semantic(Semantic)

    /// The value appropriate for the given context.
    case automatic
}

extension Amount: Equatable where Semantic: Equatable, Exact: Equatable {}
