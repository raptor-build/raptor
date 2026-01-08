//
// Xcode.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

public struct Xcode: SyntaxHighlighterTheme {
    public func theme(code: Content, colorScheme: ColorScheme) -> Content {
        switch colorScheme {
        case .dark:
            code
                .backgroundColor(Color(hex: "#202025"))
                .plainTextColor(Color(hex: "#f8f8f2"))
                .keywordColor(Color(hex: "#FF4FA3"))
                .typeColor(Color(hex: "#76E6FF"))
                .functionColor(Color(hex: "#54dcfc"))
                .variableColor(Color(hex: "#f8f8f2"))
                .propertyColor(Color(hex: "#f92672"))
                .parameterColor(Color(hex: "#f8f8f2"))
                .stringColor(Color(hex: "#FC5661"))
                .numberColor(Color(hex: "#ae81ff"))
                .commentColor(Color(html: .slateGray))
                .operatorColor(Color(hex: "#f8f8f2"))
                .punctuationColor(Color(hex: "#f8f8f2"))
                .annotationColor(Color(hex: "#e6db74"))
                .directiveColor(Color(hex: "#e6db74"))
                .errorColor(Color(hex: "#fd971f"))

        case .light, .any:
            code
                .backgroundColor(Color(hex: "#f9f9f9"))
                .plainTextColor(.black)
                .keywordColor(Color(hex: "#AA0D91"))
                .typeColor(Color(hex: "#5C2699"))
                .functionColor(Color(hex: "#3F6E74"))
                .variableColor(Color(hex: "#3F6E74"))
                .propertyColor(Color(hex: "#836C28"))
                .parameterColor(Color(hex: "#3F6E74"))
                .stringColor(Color(hex: "#C41A16"))
                .numberColor(Color(hex: "#1C00CF"))
                .commentColor(Color(hex: "#007400"))
                .operatorColor(.black)
                .punctuationColor(.black)
                .annotationColor(Color(hex: "#C41A16"))
                .directiveColor(Color(hex: "#AA0D91"))
                .errorColor(.red)
        }
    }
}

public extension SyntaxHighlighterTheme where Self == Xcode {
    static var xcode: Self { Xcode() }
}
