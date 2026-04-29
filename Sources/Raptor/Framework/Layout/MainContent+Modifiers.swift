//
// MainContent+Layout.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension Main {
    /// Adds a data attribute to the element.
    /// - Parameters:
    ///   - name: The name of the data attribute
    ///   - value: The value of the data attribute
    /// - Returns: The modified `Body` element
    func data(_ name: String, _ value: String) -> Self {
        var copy = self
        copy.bodyAttributes.data.append(.init(name: name, value: value))
        return copy
    }

    /// Adds a custom attribute to the element.
    /// - Parameters:
    ///   - name: The name of the custom attribute
    ///   - value: The value of the custom attribute
    /// - Returns: The modified `HTML` element
    func attribute(_ name: String, _ value: String) -> Self {
        var copy = self
        copy.bodyAttributes.append(customAttributes: .init(name: name, value: value))
        return copy
    }
}

public extension Main {
    /// Applies vertical margin to this page container.
    /// Defaults to 20 pixels.
    func margin(_ amount: Int = 20) -> Self {
        margin(.vertical, amount)
    }

    /// Applies margin on selected vertical edges.
    /// - Parameters:
    ///   - edges: The vertical edges where this margin should be applied.
    ///   - amount: The amount of margin in pixels.
    func margin(_ edges: Edge, _ amount: Int) -> Self {
        let styles = edges.spacingStyles(amount: "\(amount)px")
        var copy = self
        copy.attributes.append(styles: styles)
        return copy
    }

    /// Sets a solid background color for the current page.
    /// - Parameter color: The background color to apply.
    /// - Returns: A modified element that registers the background color
    ///   with the active rendering context.
    func background(_ color: Color) -> Self {
        BuildContext.registerBackground(color)
        return self
    }

    /// Sets a gradient background for the current page.
    /// - Parameter gradient: The gradient to apply as the background.
    /// - Returns: A modified element that registers the background gradient
    ///   with the active rendering context.
    func background(_ gradient: Gradient) -> Self {
        BuildContext.registerBackground(gradient)
        return self
    }

    /// Extends the site's content to the full width of the viewport.
    /// - Returns: A copy of the current element that ignores page gutters.
    func ignorePageGutters() -> Self {
        var copy = self
        copy.bodyAttributes.remove(classes: "container")
        return copy
    }
}

public extension Main {
    /// A modifier that sets the preferred color scheme for a container element.
    /// - Parameter colorScheme: The preferred color scheme to use. If `nil`, no color scheme is enforced.
    /// - Returns: A modified `Main` element with the specified color scheme.
    func preferredColorScheme(_ scheme: SystemColorScheme?) -> Self {
        var copy = self
        copy.colorScheme = scheme
        return copy
    }

    /// Applies styles to the page that vary across environment conditions.
    /// - Parameters:
    ///   - keyPath: The environment value that drives the effect.
    ///   - transform: A closure that configures a `MainProxy`
    ///     for each environment case.
    /// - Returns: A modified `Main` with the generated styles applied.
    func environmentEffect<V: EnvironmentEffectValue>(
        _ keyPath: KeyPath<EnvironmentEffectValues, V.Type>,
        @EnvironmentEffectBuilder
        _ transform: @escaping (EmptyEnvironmentEffect, V) -> EmptyEnvironmentEffect
    ) -> Self {
        let casedStyles: OrderedDictionary<V, [Property]> =
            .init(uniqueKeysWithValues: V.allCases.compactMap { value in
                let proxy = transform(EmptyEnvironmentEffect(), value)
                guard !proxy.properties.isEmpty else { return nil }
                return (value, proxy.properties)
            })

        let config = EnvironmentEffectConfiguration<V>(casedStyles: casedStyles)
        BuildContext.register(config.scopedStyle)

        var copy = self
        copy.bodyAttributes.append(classes: config.scopedStyle.allClasses)
        return copy
    }
}
