//
// BuildContext.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import OrderedCollections

/// Collects all build-wide artifacts generated during HTML rendering.
/// A fresh `BuildContext` is created for each page and merged into the
/// site's aggregated output by the publishing pipeline.
package struct BuildContext: Sendable {
    /// A background style applied to a page.
    enum PageBackground: Sendable {
        /// A solid background color.
        case color(Color?)

        /// A gradient background.
        case gradient(Gradient?)

        /// The CSS property generated for this background.
        var styleProperties: [Property] {
            switch self {
            case .color(let color):
                if let color {
                   return [.variable("bg-page", value: color.description),
                     .variable("bg-gradient", value: "unset")]
                }

            case .gradient(let gradient):
                if let gradient {
                   return [.variable("bg-gradient", value: gradient.description)]
                }
            }

            return []
        }
    }

    /// The task-local store containing the active build context.
    @TaskLocal private static var currentStore: BuildContextStore?

    /// Returns the active build context, or an empty one if none is active.
    static var current: BuildContext {
        get { currentStore?.value ?? .init() }
        set { currentStore?.value = newValue }
    }

    /// All syntax highlighter languages referenced in the page.
    package var syntaxHighlighterLanguages: OrderedSet<SyntaxHighlighterLanguage> = []

    /// All syntax highlighter themes referenced in the page.
    package var syntaxHighlighterThemes: [any SyntaxHighlighterTheme] = []

    /// All global CSS styles registered during rendering.
    package var styles: [any Style] = []

    /// All scoped CSS styles attached to components.
    package var scopedStyles: [ScopedStyle] = []

    /// All animations referenced by the page.
    package var animations: OrderedSet<Animation> = []

    /// Non-fatal warnings emitted while rendering.
    package var warnings: OrderedSet<String> = []

    /// Fatal or recoverable rendering errors.
    package var errors: OrderedSet<BuildError> = []

    /// Presentation contexts created by interactive components.
    var presentations: OrderedDictionary<String, PresentationContext> = [:]

    /// The control label style used by parent elements.
    var controlLabelStyle: ControlLabelStyle? = .top

    /// The color of the list row being rendered.
    var listRowContexts: OrderedDictionary<String, ListRowContext> = [:]

    /// Whether a fixed navigation bar adds padding to `<body>`.
    var navigationReservesSpace: Bool = false

    /// The background color of the page being rendered.
    var pageBackground: PageBackground?

    /// All fonts required by the rendered markup.
    package var fonts: OrderedSet<Font> = []

    /// Whether the page being rendered uses a segmented control.
    var includesSegmentedControl = false

    /// Injectable plain text from the current widget being rendered.
    var widgetContent: String?

    /// Whether the current widget being rendered
    var widgetIsRawHTML = false

    package init() {}

    /// Merges another `SiteContext` into this one.
    package func merging(_ other: BuildContext) -> BuildContext {
        var copy = self
        copy.syntaxHighlighterLanguages.formUnion(other.syntaxHighlighterLanguages)
        copy.syntaxHighlighterThemes += other.syntaxHighlighterThemes
        copy.fonts.formUnion(other.fonts)
        copy.animations.formUnion(other.animations)
        copy.scopedStyles.append(contentsOf: other.scopedStyles)
        copy.styles += other.styles
        copy.warnings.formUnion(other.warnings)
        copy.errors.formUnion(other.errors)
        copy.presentations.merge(other.presentations) { _, new in new }
        return copy
    }

    /// Executes `body` with mutable access to the current build context.
    @discardableResult
    static func withMutableContext<R>(
        _ body: (inout BuildContext) -> R
    ) -> R {
        guard let box = currentStore else {
            fatalError("BuildContext.withMutableContext called outside BuildContext.current scope.")
        }
        return body(&box.value)
    }

    /// Creates a fresh build context for the duration of `body`, restoring
    /// any previous context afterward.
    static package func withNewContext<R>(
        _ body: () -> R
    ) -> (result: R, context: BuildContext) {
        let box = BuildContextStore(.init())

        let result = BuildContext.$currentStore.withValue(box) {
            body()
        }

        return (result, box.value)
    }

    static package func withNewContext<R>(
        _ body: () async -> R
    ) async -> (result: R, context: BuildContext) {
        let box = BuildContextStore(.init())

        let result = await BuildContext.$currentStore.withValue(box) {
            await body()
        }

        return (result, box.value)
    }

    /// Creates a fresh build context for the duration of `body`, restoring
    /// any previous context afterward.
    static package func withNewContext(
        _ body: () async throws -> Void
    ) async rethrows {
        let box = BuildContextStore(.init())
        try await BuildContext.$currentStore.withValue(box) {
            try await body()
        }
    }

    /// Creates a fresh build context for the duration of `body`, restoring
    /// any previous context afterward.
    static package func withNewContext<R>(
        _ body: () async throws -> R
    ) async rethrows -> (result: R, context: BuildContext) {
        let box = BuildContextStore(.init())
        let result = try await BuildContext.$currentStore.withValue(box) {
            try await body()
        }
        return (result, box.value)
    }

    /// Creates a fresh build context for the duration of `body`, restoring
    /// any previous context afterward.
    static package func withNewContext<R>(
        _ body: () throws -> R
    ) rethrows -> (result: R, context: BuildContext) {
        let box = BuildContextStore(.init())
        let result = try BuildContext.$currentStore.withValue(box) {
            try body()
        }
        return (result, box.value)
    }
}

extension BuildContext {
    /// Registers a syntax highlighter used during rendering.
    static func includesSegmentedControl(_ includes: Bool) {
        withMutableContext { $0.includesSegmentedControl = includes }
    }

    /// Registers a syntax highlighter used during rendering.
    static func register(_ highlighter: SyntaxHighlighterLanguage) {
        withMutableContext { $0.syntaxHighlighterLanguages.append(highlighter) }
    }

    /// Sets content for injection into the current widget being rendered.
    static func setWidgetContent(_ content: String?) {
        withMutableContext { $0.widgetContent = content }
    }

    /// Registers a syntax highlighter used during rendering.
    static func register(_ theme: any SyntaxHighlighterTheme) {
        withMutableContext { $0.syntaxHighlighterThemes.append(theme) }
    }

    /// Registers a global CSS style.
    static func register(_ style: some Style) {
        withMutableContext {
            guard !$0.styles.contains(where: { $0.className == style.className }) else { return }
            $0.styles.append(style)
        }
    }

    /// Registers a scoped CSS style.
    static func register(_ style: ScopedStyle) {
        withMutableContext { $0.scopedStyles.append(style) }
    }

    /// Registers a required font family.
    static func register(_ font: Font) {
        withMutableContext { $0.fonts.append(font) }
    }

    /// Registers an animation definition.
    static func register(_ animation: Animation) {
        withMutableContext { $0.animations.append(animation) }
    }

    /// Registers a page background color.
    static func registerBackground(_ color: Color?) {
        withMutableContext { $0.pageBackground = .color(color) }
    }

    /// Registers a page background gradient.
    static func registerBackground(_ gradient: Gradient?) {
        withMutableContext { $0.pageBackground = .gradient(gradient) }
    }

    /// Registers or updates a presentation context.
    static func register(_ id: String, context: PresentationContext) {
        withMutableContext { $0.presentations[id] = context }
    }

    /// Replaces all presentation contexts.
    static func register(_ dictionary: OrderedDictionary<String, PresentationContext>) {
        withMutableContext { $0.presentations = dictionary }
    }

    /// Records a non-fatal rendering warning.
    static func logWarning(_ message: String) {
        withMutableContext { $0.warnings.append(message) }
    }

    /// Records a rendering error.
    static func logError(_ error: BuildError) {
        withMutableContext { $0.errors.append(error) }
    }

    /// Sets the control label style.
    static func set(_ labelStyle: ControlLabelStyle) {
        withMutableContext { $0.controlLabelStyle = labelStyle }
    }

    static func resetControlLabelStyle() {
        withMutableContext { $0.controlLabelStyle = .top }
    }

    /// Sets the list row background.
    static func registerListRowBackground(_ id: String, _ color: Color) {
        withMutableContext {
            var context = $0.listRowContexts[id] ?? ListRowContext()
            context.styles.append(.variable("list-row-bg", value: color.description))
            $0.listRowContexts[id] = context
        }
    }

    /// Sets the list row padding.
    static func registerListRowSpacing(_ id: String, _ spacing: Double) {
        withMutableContext {
            var context = $0.listRowContexts[id] ?? ListRowContext()
            context.styles.append(.variable("list-row-spacing", value: LengthUnit.px(spacing).css))
            $0.listRowContexts[id] = context
        }
    }

    /// Sets the list row padding.
    static func registerListRowPadding(_ id: String, _ styles: [Property]) {
        withMutableContext {
            var context = $0.listRowContexts[id] ?? ListRowContext()
            context.styles.append(contentsOf: styles)
            $0.listRowContexts[id] = context
        }
    }

    /// Sets the list row radius.
    static func registerListRowCornerRadius(_ id: String, _ styles: [Property]) {
        withMutableContext {
            var context = $0.listRowContexts[id] ?? ListRowContext()
            context.styles.append(contentsOf: styles)
            $0.listRowContexts[id] = context
        }
    }

    /// Sets the list row radius.
    static func registerListRowBorder(_ id: String, _ styles: [Property]) {
        withMutableContext {
            var context = $0.listRowContexts[id] ?? ListRowContext()
            context.styles.append(contentsOf: styles)
            $0.listRowContexts[id] = context
        }
    }
}
