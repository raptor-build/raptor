//
// Solarized.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

public struct Solarized: SyntaxHighlighterTheme {
    public func theme(code: Content, colorScheme: ColorScheme) -> Content {
        switch colorScheme {
        case .dark:
            code
                .backgroundColor(Color(hex: "#002b36"))
                .plainTextColor(Color(hex: "#839496"))
                .keywordColor(Color(hex: "#268bd2"))
                .typeColor(Color(hex: "#268bd2"))
                .functionColor(Color(hex: "#268bd2"))
                .variableColor(Color(hex: "#268bd2"))
                .propertyColor(Color(hex: "#268bd2"))
                .parameterColor(Color(hex: "#268bd2"))
                .stringColor(Color(hex: "#859900"))
                .numberColor(Color(hex: "#859900"))
                .commentColor(Color(hex: "#586e75"))
                .operatorColor(Color(hex: "#EDEDED"))
                .punctuationColor(Color(hex: "#93a1a1"))
                .annotationColor(Color(hex: "#F9EE98"))
                .directiveColor(Color(hex: "#F9EE98"))
                .errorColor(Color(hex: "#dc322f"))

        case .light, .any:
            code
                .backgroundColor(Color(hex: "#fdf6e3"))
                .plainTextColor(Color(hex: "#657b83"))
                .keywordColor(Color(hex: "#859900"))
                .typeColor(Color(hex: "#268bd2"))
                .functionColor(Color(hex: "#b58900"))
                .variableColor(Color(hex: "#cb4b16"))
                .propertyColor(Color(hex: "#268bd2"))
                .parameterColor(Color(hex: "#cb4b16"))
                .stringColor(Color(hex: "#2aa198"))
                .numberColor(Color(hex: "#268bd2"))
                .commentColor(Color(hex: "#93a1a1"))
                .operatorColor(Color(hex: "#657b83"))
                .punctuationColor(Color(hex: "#586e75"))
                .annotationColor(Color(hex: "#859900"))
                .directiveColor(Color(hex: "#859900"))
                .errorColor(Color(hex: "#dc322f"))
        }
    }
}

public extension SyntaxHighlighterTheme where Self == Solarized {
    static var solarized: Self { Solarized() }
}
