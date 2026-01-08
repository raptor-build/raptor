//
// Prism.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

public struct Prism: SyntaxHighlighterTheme {
    public func theme(code: Content, colorScheme: ColorScheme) -> Content {
        switch colorScheme {
        case .dark:
            code
                .backgroundColor(Color(hex: "#4c3f33"))
                .plainTextColor(Color(hex: "#ffffff"))
                .keywordColor(Color(hex: "#d1939e"))
                .typeColor(Color(hex: "#d1939e"))
                .functionColor(Color(hex: "#d1939e"))
                .variableColor(Color(hex: "#f4b73d"))
                .propertyColor(Color(hex: "#d1939e"))
                .parameterColor(Color(hex: "#f4b73d"))
                .stringColor(Color(hex: "#bce051"))
                .numberColor(Color(hex: "#d1939e"))
                .commentColor(Color(hex: "#997f66"))
                .operatorColor(Color(hex: "#f4b73d"))
                .punctuationColor(Color(hex: "#ffffff").opacity(0.7))
                .annotationColor(Color(hex: "#d1939e"))
                .directiveColor(Color(hex: "#d1939e"))
                .errorColor(Color(hex: "#e90"))

        case .light, .any:
            code
                .backgroundColor(Color(hex: "#f5f2f0"))
                .plainTextColor(Color(hex: "#000000"))
                .keywordColor(Color(hex: "#0077aa"))
                .typeColor(Color(hex: "#dd4a68"))
                .functionColor(Color(hex: "#dd4a68"))
                .variableColor(Color(hex: "#e90"))
                .propertyColor(Color(hex: "#905"))
                .parameterColor(Color(hex: "#e90"))
                .stringColor(Color(hex: "#690"))
                .numberColor(Color(hex: "#905"))
                .commentColor(Color(hex: "#708090"))
                .operatorColor(Color(hex: "#9a6e3a"))
                .punctuationColor(Color(hex: "#999999"))
                .annotationColor(Color(hex: "#0077aa"))
                .directiveColor(Color(hex: "#0077aa"))
                .errorColor(Color(hex: "#e90"))
        }
    }
}

public extension SyntaxHighlighterTheme where Self == Prism {
    static var prism: Self { Prism() }
}
