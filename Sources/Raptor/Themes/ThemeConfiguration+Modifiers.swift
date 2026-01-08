//
// ThemedSite+Modifiers.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension ThemeConfiguration {
    /// Sets the primary accent color.
    /// - Parameter color: The color to use for the theme’s accent.
    /// - Returns: A new themed site with the specified accent color.
    func accent(_ color: Color) -> Self {
        var copy = self
        copy.accent = color
        return copy
    }

    /// Sets the default text color.
    /// - Parameter color: The color to use for body text and general foreground elements.
    /// - Returns: A new themed site with the specified foreground color.
    func foregroundStyle(_ color: Color) -> Self {
        var copy = self
        copy.foreground = color
        return copy
    }

    /// Sets the background color.
    /// - Parameter color: The color to use for the page or main content background.
    /// - Returns: A new themed site with the specified background color.
    func background(_ color: Color) -> Self {
        var copy = self
        copy.backgroundColor = color
        return copy
    }

    /// Sets the background color.
    /// - Parameter gradient: The gradient to use for the page or main content background.
    /// - Returns: A new themed site with the specified background gradient.
    func background(_ gradient: Gradient) -> Self {
        var copy = self
        copy.backgroundGradient = gradient
        return copy
    }

    /// Sets the monospace font family.
    /// - Parameter font: The font to use for monospace elements like code.
    /// - Returns: A new themed site with the specified monospace font.
    func codeFont(_ font: Font) -> Self {
        var copy = self
        copy.monospaceFont = font
        return copy
    }

    /// Sets the base body font family.
    /// - Parameter font: The font to use for standard body text.
    /// - Returns: A new themed site with the specified body font.
    func font(_ font: Font, smoothing: FontSmoothingMode = .automatic) -> Self {
        var copy = self
        copy.font = font
        copy.fontSmoothing = smoothing
        return copy
    }

    /// Sets the heading font family.
    /// - Parameter font: The font to use for heading elements.
    /// - Returns: A new themed site with the specified heading font.
    func titleFont(_ font: Font, smoothing: FontSmoothingMode = .automatic) -> Self {
        var copy = self
        copy.headingFont = font
        copy.headingFontSmoothing = smoothing
        return copy
    }

    /// Sets the line spacing for a specific text role.
    /// - Parameters:
    ///   - spacing: The line height to apply.
    ///   - role: The text role to update.
    /// - Returns: A themed site with the updated line spacing.
    func lineSpacing(
        _ spacing: Double,
        for style: FontStyle = .body
    ) -> Self {
        var copy = self
        copy.setLineSpacing(spacing, for: style)
        return copy
    }

    /// Sets the inline code font size.
    /// - Parameter size: The font size to use for inline code elements.
    /// - Returns: A new themed site with the specified inline code font size.
    func inlineCodeStyle(_ size: some Style) -> Self {
        var copy = self
        copy.inlineCodeStyle = AnyStyle(size)
        return copy
    }

    /// Sets the syntax highlighter theme.
    /// - Parameter theme: The syntax highlight theme to apply.
    /// - Returns: A new themed site with the specified syntax highlighting theme.
    func syntaxHighlighterTheme(_ theme: some SyntaxHighlighterTheme) -> Self {
        var copy = self
        copy.syntaxHighlighterTheme = theme
        return copy
    }

    /// Sets the syntax highlighter theme for inline code.
    /// - Parameter theme: The syntax highlight theme to apply.
    /// - Returns: A new themed site with the specified syntax highlighting theme.
    func inlineCodeTheme(_ theme: some SyntaxHighlighterTheme) -> Self {
        var copy = self
        copy.inlineCodeTheme = theme
        return copy
    }

    /// Sets a fixed font size for a specific text role.
    /// - Parameters:
    ///   - size: The fixed size in pixels.
    ///   - styles: The text styles to update.
    /// - Returns: A themed site with the updated font size.
    func fontWeight(
        _ weight: Font.Weight,
        for style: FontStyle
    ) -> Self {
        var copy = self
        copy.setFontWeight(weight, for: style)
        return copy
    }

    /// Sets a fixed font size for a specific text role.
    /// - Parameters:
    ///   - size: The fixed size in pixels.
    ///   - style: The text role to update.
    /// - Returns: A themed site with the updated font size.
    func fontSize(
        _ size: Double,
        for style: FontStyle
    ) -> Self {
        var copy = self
        let pixels = LengthUnit.px(size)
        copy.setFontSize(
            DynamicValues(compact: pixels, regular: pixels, expanded: pixels),
            for: style
        )
        return copy
    }

    /// Sets a fixed font size for a specific text role.
    /// - Parameters:
    ///   - size: The fixed size to apply.
    ///   - role: The text role to update.
    /// - Returns: A themed site with the updated font size.
    func fontSize(
        _ size: FontSize,
        for style: FontStyle
    ) -> Self {
        var copy = self
        let unit = size.value

        copy.setFontSize(
            DynamicValues(compact: unit, regular: unit, expanded: unit),
            for: style
        )

        return copy
    }

    /// Sets a fluid minimum, ideal, and maximum font size for a text role.
    /// - Parameters:
    ///   - min: The size used on compact widths.
    ///   - ideal: The size used on regular widths.
    ///   - max: The size used on expanded widths.
    ///   - style: The text role to update.
    /// - Returns: A themed site with the updated font size.
    func fontSize(
        min: Double? = nil,
        ideal: Double,
        max: Double? = nil,
        for style: FontStyle
    ) -> Self {
        var copy = self
        copy.setFontSize(
            DynamicValues(
                compact: min.map(LengthUnit.px),
                regular: LengthUnit.px(ideal),
                expanded: max.map(LengthUnit.px)
            ),
            for: style
        )
        return copy
    }

    /// Sets a minimum, ideal, and maximum font size for a text role.
    /// - Parameters:
    ///   - min: The size used on compact widths.
    ///   - ideal: The size used on regular widths.
    ///   - max: The size used on expanded widths.
    ///   - style: The text role to update.
    /// - Returns: A themed site with the updated font size.
    func fontSize(
        min: FontSize? = nil,
        ideal: FontSize,
        max: FontSize? = nil,
        for style: FontStyle
    ) -> Self {
        var copy = self

        copy.setFontSize(
            DynamicValues(
                compact: min?.value,
                regular: ideal.value,
                expanded: max?.value
            ),
            for: style
        )

        return copy
    }

    /// Sets the maximum width of the site's content.
    /// - Parameter width: A content width expressed as either a fixed value or a fractional viewport width.
    /// - Returns: A themed site with the updated content width.
    func contentWidth(max width: ContentWidth) -> Self {
        var copy = self
        switch width {
        case .fixed(let value):
            copy.maxContentWidth = .px(value)
        case .proportional(let value):
            copy.maxContentWidth = .vw(value * 100)
        }
        return copy
    }

    /// Sets the maximum width of the site's content using a fixed width.
    /// - Parameter max: The maximum width of the site's content in points.
    /// - Returns: A themed site with the updated content width.
    func contentWidth(max width: Int) -> Self {
        contentWidth(max: .fixed(Double(width)))
    }
}

private extension ThemeConfiguration {
    /// Assigns a responsive font size (`DynamicValues`) to a specific text style.
    /// - Parameters:
    ///   - values: The responsive size values to apply (compact / regular / expanded).
    ///   - style: The text style to update.
    mutating func setFontSize(
        _ values: DynamicValues<LengthUnit>,
        for styles: FontStyle
    ) {
        if styles.contains(.body) { bodyFontSize = values }
        if styles.contains(.title1) { h1Size = values }
        if styles.contains(.title2) { h2Size = values }
        if styles.contains(.title3) { h3Size = values }
        if styles.contains(.title4) { h4Size = values }
        if styles.contains(.title5) { h5Size = values }
        if styles.contains(.title6) { h6Size = values }
        if styles.contains(.codeBlock) { codeBlockFontSize = values }
    }

    /// Assigns a font weight value to one or more text styles.
    /// - Parameters:
    ///   - weight: The font weight to apply.
    ///   - styles: One or more text styles to update.
    mutating func setFontWeight(
        _ weight: Font.Weight,
        for styles: FontStyle
    ) {
        if styles.contains(.body) { bodyWeight = weight }
        if styles.contains(.title1) { h1Weight = weight }
        if styles.contains(.title2) { h2Weight = weight }
        if styles.contains(.title3) { h3Weight = weight }
        if styles.contains(.title4) { h4Weight = weight }
        if styles.contains(.title5) { h5Weight = weight }
        if styles.contains(.title6) { h6Weight = weight }
        if styles.contains(.codeBlock) { codeBlockWeight = weight }
    }

    /// Assigns a line-spacing value to a specific text style.
    /// - Parameters:
    ///   - spacing: The line height to apply.
    ///   - style: The text style to update.
    mutating func setLineSpacing(
        _ spacing: Double,
        for styles: FontStyle
    ) {
        if styles.contains(.body) { bodyLineSpacing = spacing }
        if styles.contains(.title1) { h1LineSpacing = spacing }
        if styles.contains(.title2) { h2LineSpacing = spacing }
        if styles.contains(.title3) { h3LineSpacing = spacing }
        if styles.contains(.title4) { h4LineSpacing = spacing }
        if styles.contains(.title5) { h5LineSpacing = spacing }
        if styles.contains(.title6) { h6LineSpacing = spacing }
        if styles.contains(.codeBlock) { codeBlockLineSpacing = spacing }
    }
}
