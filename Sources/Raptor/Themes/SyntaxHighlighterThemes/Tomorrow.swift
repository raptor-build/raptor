//
// Tomorrow.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

//
// Tomorrow.swift
// Raptor Build
// https://raptor.build
//

public struct Tomorrow: SyntaxHighlighterTheme {
    public func theme(code: Content, colorScheme: ColorScheme) -> Content {
        switch colorScheme {
        case .dark:
            code
                .backgroundColor(Color(hex: "#2d2d2d"))
                .plainTextColor(Color(hex: "#cccccc"))
                .keywordColor(Color(hex: "#cc99cd"))
                .typeColor(Color(hex: "#f8c555"))
                .functionColor(Color(hex: "#f08d49"))
                .variableColor(Color(hex: "#7ec699"))
                .propertyColor(Color(hex: "#f8c555"))
                .parameterColor(Color(hex: "#7ec699"))
                .stringColor(Color(hex: "#7ec699"))
                .numberColor(Color(hex: "#f08d49"))
                .commentColor(Color(hex: "#999999"))
                .operatorColor(Color(hex: "#67cdcc"))
                .punctuationColor(Color(hex: "#cccccc"))
                .annotationColor(Color(hex: "#e2777a"))
                .directiveColor(Color(hex: "#cc99cd"))
                .errorColor(Color(hex: "#cc99cd"))

        case .light, .any:
            code
                .backgroundColor(Color(hex: "#ffffff"))
                .plainTextColor(Color(hex: "#4d4d4c"))
                .keywordColor(Color(hex: "#9a6fa8"))
                .directiveColor(Color(hex: "#9a6fa8"))
                .typeColor(Color(hex: "#2f5d8a"))
                .propertyColor(Color(hex: "#2f5d8a"))
                .numberColor(Color(hex: "#2f5d8a"))
                .functionColor(Color(hex: "#4f9e99"))
                .stringColor(Color(hex: "#7fa65a"))
                .variableColor(Color(hex: "#000000"))
                .parameterColor(Color(hex: "#000000"))
                .commentColor(Color(hex: "#8e908c"))
                .operatorColor(Color(hex: "#4d4d4c"))
                .punctuationColor(Color(hex: "#4d4d4c"))
                .annotationColor(Color(hex: "#c82829"))
                .errorColor(Color(hex: "#ff7f7f"))
        }
    }
}

public extension SyntaxHighlighterTheme where Self == Tomorrow {
    static var tomorrow: Self { Tomorrow() }
}
