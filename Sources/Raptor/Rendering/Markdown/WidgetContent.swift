//
// WidgetContent.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Provides access to content injected into a post widget via Markdown token syntax.
///
/// `@WidgetContent` reads text supplied by a widget token such as:
///
/// ```markdown
/// @{MyWidget:Hello world}
/// ```
///
/// The text after the colon is injected into the widget during post preprocessing.
/// If no content is provided, a required default value is used.
///
/// The wrapped value is only available while the widget is being rendered.
/// Accessing it outside of a render pass is a programmer error and will trap.
@propertyWrapper
public struct WidgetContent: Sendable {
    private let defaultValue: String

    /// Creates a widget content accessor.
    ///
    /// - Parameter default: The value used when no content is provided
    ///   by the surrounding widget token.
    public init(default defaultValue: String) {
        self.defaultValue = defaultValue
    }

    /// The injected widget content.
    ///
    /// This value is resolved during widget rendering. If no content
    /// is provided, the default value is returned.
    ///
    /// Accessing this property outside of widget rendering is a
    /// programmer error and will trap.
    public var wrappedValue: String {
        guard let content = BuildContext.current.widgetContent else {
            BuildContext.logError(.failedToReadContextValue("@PostWidget"))
            return defaultValue
        }

        return content
    }
}
