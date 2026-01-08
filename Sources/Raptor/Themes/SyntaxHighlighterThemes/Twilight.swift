//
// Twilight.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

public struct Twilight: SyntaxHighlighterTheme {
    public func theme(code: Content, colorScheme: ColorScheme) -> Content {
        switch colorScheme {
        case .dark:
            code
                .backgroundColor(Color(hex: "#141414"))
                .plainTextColor(Color(hex: "#ffffff"))
                .keywordColor(Color(hex: "#f9ed99"))
                .typeColor(Color(hex: "#f9ed99"))
                .functionColor(Color(hex: "#f9ed99"))
                .variableColor(Color(hex: "#909e6a"))
                .propertyColor(Color(hex: "#f9ed99"))
                .parameterColor(Color(hex: "#909e6a"))
                .stringColor(Color(hex: "#909e6a"))
                .numberColor(Color(hex: "#ce6849"))
                .commentColor(Color(hex: "#777777"))
                .operatorColor(Color(hex: "#909e6a"))
                .punctuationColor(Color(hex: "#ffffff").opacity(0.7))
                .annotationColor(Color(hex: "#909e6a"))
                .directiveColor(Color(hex: "#7385a5"))
                .errorColor(Color(hex: "#e8c062"))

        case .light, .any:
            code
                .backgroundColor(Color(hex: "#f7f7f4"))
                .plainTextColor(Color(hex: "#1f1f1f"))
                .keywordColor(Color(hex: "#8a7f00"))
                .typeColor(Color(hex: "#8a7f00"))
                .functionColor(Color(hex: "#8a7f00"))
                .variableColor(Color(hex: "#556b2f"))
                .propertyColor(Color(hex: "#8a7f00"))
                .parameterColor(Color(hex: "#556b2f"))
                .stringColor(Color(hex: "#556b2f"))
                .numberColor(Color(hex: "#b24a2f"))
                .commentColor(Color(hex: "#8a8a8a"))
                .operatorColor(Color(hex: "#556b2f"))
                .punctuationColor(Color(hex: "#1f1f1f"))
                .annotationColor(Color(hex: "#556b2f"))
                .directiveColor(Color(hex: "#4f6f8f"))
                .errorColor(Color(hex: "#c9a000"))
        }
    }
}

public extension SyntaxHighlighterTheme where Self == Twilight {
    static var twilight: Self { Twilight() }
}
