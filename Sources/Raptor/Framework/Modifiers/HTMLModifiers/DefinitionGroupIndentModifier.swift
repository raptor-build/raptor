//
// DefinitionGroupIndentModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Controls the horizontal indentation applied to definition groups.
public enum DefinitionGroupIndent: Sendable, Hashable {
    /// A fixed indentation measured in pixels.
    case fixed(Double)

    /// An indentation scaled relative to the current font size.
    case scaled(Double)

    var lengthUnit: LengthUnit {
        switch self {
        case .fixed(let value): .px(value)
        case .scaled(let value): .em(value)
        }
    }
}

public extension HTML {
    /// Sets the horizontal indentation used for definition groups.
    /// - Parameter indent: The indentation value, specified as either a fixed
    ///   pixel amount or a value scaled relative to the current font size.
    /// - Returns: A modified HTML element with the definition group indentation applied.
    func definitionGroupIndent(_ indent: DefinitionGroupIndent) -> some HTML {
        self.style(.variable("definition-group-indent", value: indent.lengthUnit.css))
    }
}
