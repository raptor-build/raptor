//
// SyntaxHighlighterThemeConfiguration.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

public struct SyntaxHighlighterThemeConfiguration: Sendable, Hashable, Equatable {
    /// Fallback color applied to all unset token colors.
    var defaultColor: Color = .primary

    /// Background color for code blocks.
    var backgroundColor: Color = .clear

    /// Default foreground color for unclassified tokens.
    var plainTextColor: Color?

    /// Keywords like `if`, `func`, `return`.
    var keywordColor: Color?

    /// Type names (`String`, `View`, `URL`).
    var typeColor: Color?

    /// Function and method names.
    var functionColor: Color?

    /// Variable and binding names.
    var variableColor: Color?

    /// Property access (`foo.bar`).
    var propertyColor: Color?

    /// Parameter names in function signatures.
    var parameterColor: Color?

    /// Omitted / wildcard parameters like `_`
    var unlabeledParameterColor: Color?

    /// String and character literals.
    var stringColor: Color?

    /// Numeric and boolean literals.
    var numberColor: Color?

    /// Comments and documentation.
    var commentColor: Color?

    /// Attributes / annotations.
    var annotationColor: Color?

    /// Preprocessor directives.
    var directiveColor: Color?

    /// Invalid or error tokens.
    var errorColor: Color?

    /// Operators like `+`, `==`, `->`.
    var operatorColor: Color?

    /// Punctuation like commas and colons.
    var punctuationColor: Color?

    /// Delimiters used for string literals (e.g. quotes).
    var stringDelimiterColor: Color?

    /// Delimiters used for string interpolation (e.g. `${`, `}`).
    var interpolationDelimiterColor: Color?
}

public extension SyntaxHighlighterThemeConfiguration {
    /// Sets the background color for code blocks.
    /// - Parameter color: The background color to apply.
    /// - Returns: A new configuration with the updated background color.
    func backgroundColor(_ color: Color) -> Self {
        var copy = self
        copy.backgroundColor = color
        return copy
    }

    /// Sets the default color for unclassified tokens.
    /// - Parameter color: The plain text color.
    /// - Returns: A new configuration with the updated plain text color.
    func plainTextColor(_ color: Color) -> Self {
        var copy = self
        copy.plainTextColor = color
        return copy
    }

    /// Sets the color used for language keywords.
    /// - Parameter color: The keyword color.
    /// - Returns: A new configuration with the updated keyword color.
    func keywordColor(_ color: Color) -> Self {
        var copy = self
        copy.keywordColor = color
        return copy
    }

    /// Sets the color used for type names.
    /// - Parameter color: The type name color.
    /// - Returns: A new configuration with the updated type color.
    func typeColor(_ color: Color) -> Self {
        var copy = self
        copy.typeColor = color
        return copy
    }

    /// Sets the color used for function and method names.
    /// - Parameter color: The function name color.
    /// - Returns: A new configuration with the updated function color.
    func functionColor(_ color: Color) -> Self {
        var copy = self
        copy.functionColor = color
        return copy
    }

    /// Sets the color used for variable and binding names.
    /// - Parameter color: The variable color.
    /// - Returns: A new configuration with the updated variable color.
    func variableColor(_ color: Color) -> Self {
        var copy = self
        copy.variableColor = color
        return copy
    }

    /// Sets the color used for property access.
    /// - Parameter color: The property color.
    /// - Returns: A new configuration with the updated property color.
    func propertyColor(_ color: Color) -> Self {
        var copy = self
        copy.propertyColor = color
        return copy
    }

    /// Sets the color used for parameter names.
    /// - Parameter color: The parameter color.
    /// - Returns: A new configuration with the updated parameter color.
    func parameterColor(_ color: Color) -> Self {
        var copy = self
        copy.parameterColor = color
        return copy
    }

    /// Sets the color used for omitted or wildcard parameters (`_`).
    /// - Parameter color: The omitted parameter color.
    /// - Returns: A new configuration with the updated omitted parameter color.
    func unlabeledParameterColor(_ color: Color) -> Self {
        var copy = self
        copy.unlabeledParameterColor = color
        return copy
    }

    /// Sets the color used for string and character literals.
    /// - Parameter color: The string literal color.
    /// - Returns: A new configuration with the updated string color.
    func stringColor(_ color: Color) -> Self {
        var copy = self
        copy.stringColor = color
        return copy
    }

    /// Sets the color used for numeric and boolean literals.
    /// - Parameter color: The number literal color.
    /// - Returns: A new configuration with the updated number color.
    func numberColor(_ color: Color) -> Self {
        var copy = self
        copy.numberColor = color
        return copy
    }

    /// Sets the color used for comments and documentation.
    /// - Parameter color: The comment color.
    /// - Returns: A new configuration with the updated comment color.
    func commentColor(_ color: Color) -> Self {
        var copy = self
        copy.commentColor = color
        return copy
    }

    /// Sets the color used for operators.
    /// - Parameter color: The operator color.
    /// - Returns: A new configuration with the updated operator symbol color.
    func operatorColor(_ color: Color) -> Self {
        var copy = self
        copy.operatorColor = color
        return copy
    }

    /// Sets the color used for punctuation.
    /// - Parameter color: The punctuation color.
    /// - Returns: A new configuration with the updated punctuation color.
    func punctuationColor(_ color: Color) -> Self {
        var copy = self
        copy.punctuationColor = color
        return copy
    }

    /// Sets the color used for attributes and annotations.
    /// - Parameter color: The attribute color.
    /// - Returns: A new configuration with the updated attribute color.
    func annotationColor(_ color: Color) -> Self {
        var copy = self
        copy.annotationColor = color
        return copy
    }

    /// Sets the color used for preprocessor directives.
    /// - Parameter color: The preprocessor color.
    /// - Returns: A new configuration with the updated preprocessor color.
    func directiveColor(_ color: Color) -> Self {
        var copy = self
        copy.directiveColor = color
        return copy
    }

    /// Sets the color used for invalid or error tokens.
    /// - Parameter color: The invalid token color.
    /// - Returns: A new configuration with the updated invalid color.
    func errorColor(_ color: Color) -> Self {
        var copy = self
        copy.errorColor = color
        return copy
    }

    /// Sets the color used for string delimiters.
    /// - Parameter color: The string delimiter color.
    /// - Returns: A new configuration with the updated string delimiter color.
    func stringDelimiterColor(_ color: Color) -> Self {
        var copy = self
        copy.stringDelimiterColor = color
        return copy
    }

    /// Sets the color used for string interpolation delimiters.
    /// - Parameter color: The interpolation delimiter color.
    /// - Returns: A new configuration with the updated interpolation delimiter color.
    func interpolationDelimiterColor(_ color: Color) -> Self {
        var copy = self
        copy.interpolationDelimiterColor = color
        return copy
    }

    /// Sets a fallback color applied to all token types that
    /// do not have an explicitly configured color.
    func defaultColor(_ color: Color) -> Self {
        var copy = self
        copy.defaultColor = color
        return copy
    }
}
