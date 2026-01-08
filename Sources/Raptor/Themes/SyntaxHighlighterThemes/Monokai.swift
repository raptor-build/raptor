//
// Monokai.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

public struct Monokai: SyntaxHighlighterTheme {
    public func theme(code: Content, colorScheme: ColorScheme) -> Content {
        switch colorScheme {
        case .dark:
            code
                .backgroundColor(Color(hex: "#221f22"))
                .plainTextColor(Color(hex: "#fcfcfa"))
                .keywordColor(Color(hex: "#ff6188"))
                .typeColor(Color(hex: "#78dce8"))
                .functionColor(Color(hex: "#a9dc76"))
                .variableColor(Color(hex: "#fcfcfa"))
                .propertyColor(Color(hex: "#78dce8"))
                .parameterColor(Color(hex: "#fc9867"))
                .stringColor(Color(hex: "#ffd866"))
                .numberColor(Color(hex: "#ab9df2"))
                .commentColor(Color(hex: "#727072"))
                .operatorColor(Color(hex: "#ff6188"))
                .punctuationColor(Color(hex: "#939293"))
                .annotationColor(Color(hex: "#ffd866"))
                .directiveColor(Color(hex: "#ffd866"))
                .errorColor(Color(hex: "#fc9867"))
                .interpolationDelimiterColor(Color(hex: "#ff6188"))
                .stringDelimiterColor(Color(hex: "#ff6188"))

        case .light, .any:
            code
                .backgroundColor(Color(hex: "#faf4f2"))
                .plainTextColor(Color(hex: "#29242a"))
                .keywordColor(Color(hex: "#e14775"))
                .typeColor(Color(hex: "#1c8ca8"))
                .functionColor(Color(hex: "#269d69"))
                .variableColor(Color(hex: "#29242a"))
                .propertyColor(Color(hex: "#1c8ca8"))
                .parameterColor(Color(hex: "#29242a"))
                .stringColor(Color(hex: "#cc7a0a"))
                .numberColor(Color(hex: "#7058be"))
                .commentColor(Color(hex: "#a59fa0"))
                .operatorColor(Color(hex: "#e14775"))
                .punctuationColor(Color(hex: "#29242a"))
                .annotationColor(Color(hex: "#cc7a0a"))
                .directiveColor(Color(hex: "#cc7a0a"))
                .errorColor(Color(hex: "#e16032"))
                .interpolationDelimiterColor(Color(hex: "#e14775"))
                .stringDelimiterColor(Color(hex: "#e14775"))
        }
    }
}

public extension SyntaxHighlighterTheme where Self == Monokai {
    static var monokai: Self { Monokai() }
}
