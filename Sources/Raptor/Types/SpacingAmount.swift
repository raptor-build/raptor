//
// SpacingType.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A type that represents spacing values in either exact pixels or semantic spacing amounts.
public typealias SpacingAmount = Amount<Double, SemanticSpacing>

extension SpacingAmount {
    var value: LengthUnit {
        switch self {
        case .exact(let value): .px(value)
        case .semantic(let value): .em(value.multiplier)
        default: .em(1)
        }
    }

    var inlineStyle: Property? {
        .gap(value)
    }
}
