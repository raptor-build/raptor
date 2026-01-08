//
// GitHub.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

public struct GitHub: SyntaxHighlighterTheme {
    public func theme(code: Content, colorScheme: ColorScheme) -> Content {
        switch colorScheme {
        case .dark:
            code
                .backgroundColor(Color(hex: "#24292f"))
                .plainTextColor(Color(hex: "#ffffff"))
                .keywordColor(Color(hex: "#ff7b72"))
                .typeColor(Color(hex: "#78bffe"))
                .functionColor(Color(hex: "#d2a8ff"))
                .variableColor(Color(hex: "#fea557"))
                .propertyColor(Color(hex: "#78bffe"))
                .parameterColor(Color(hex: "#fea557"))
                .stringColor(Color(hex: "#a5d6ff"))
                .numberColor(Color(hex: "#78bffe"))
                .commentColor(Color(hex: "#8b949e"))
                .operatorColor(Color(hex: "#79bffe"))
                .punctuationColor(Color(hex: "#ffffff"))
                .annotationColor(Color(hex: "#ff7b72"))
                .directiveColor(Color(hex: "#ff7b72"))
                .errorColor(Color(hex: "#ff7b72"))

        case .light, .any:
            code
                .backgroundColor(Color(hex: "#f6f8fa"))
                .plainTextColor(Color(hex: "#24292f"))
                .keywordColor(Color(hex: "#cf222e"))
                .typeColor(Color(hex: "#0550ae"))
                .functionColor(Color(hex: "#8250df"))
                .variableColor(Color(hex: "#0a3069"))
                .propertyColor(Color(hex: "#0a3069"))
                .parameterColor(Color(hex: "#0a3069"))
                .stringColor(Color(hex: "#0a3069"))
                .numberColor(Color(hex: "#0550ae"))
                .commentColor(Color(hex: "#6e7781"))
                .operatorColor(Color(hex: "#0550ae"))
                .punctuationColor(Color(hex: "#24292f"))
                .annotationColor(Color(hex: "#0550ae"))
                .directiveColor(Color(hex: "#cf222e"))
                .errorColor(Color(hex: "#cf222e"))
        }
    }
}

public extension SyntaxHighlighterTheme where Self == GitHub {
    static var github: Self { GitHub() }
}
