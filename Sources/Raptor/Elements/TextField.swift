//
// TextField.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A text input field for collecting user information in forms.
public struct TextField<Label: InlineContent>: InlineContent {
    /// Controls how read-only fields are displayed.
    public enum ReadOnlyDisplayMode: Sendable {
        /// Renders as a standard form control but non-editable.
        case control
        /// Renders as plain text without form styling.
        case plainText
        /// The appropriate display mode based on context.
        public static var automatic: Self { .control }
    }

    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The attributes applied to the `<input>`.
    public var attributes = CoreAttributes()

    /// The label text for the field.
    private var label: Label?

    /// The placeholder for the field.
    private var prompt: String?

    /// The size configuration for the text field and its label.
    private var size: ControlSize = .regular

    /// The positioning style for the field's label.
    private var style: ControlLabelStyle?

    /// The type of content the textfield modifies.
    private var textFieldType = TextContentType.text

    /// The id that links the label and the input.
    private var id = UUID().uuidString.truncatedHash

    /// Creates a new text field with the specified label and placeholder text.
    /// - Parameters:
    ///   - label: The label text to display with the field.
    ///   - prompt: The text to display when the field is empty.
    public init(_ labelKey: String, prompt promptKey: String? = nil) where Label == String {
        let text = Localizer.string(labelKey, locale: Self.locale)
        self.label = text

        if let promptKey {
            let text = Localizer.string(promptKey, locale: Self.locale)
            self.prompt = text
        }
    }

    /// Creates a new text field with the specified label and placeholder text.
    /// - Parameters:
    ///   - prompt: The text to display when the field is empty.
    ///   - label: The label text to display with the field.
    public init(
        prompt promptKey: String? = nil,
        @InlineContentBuilder label: () -> Label
    ) {
        self.label = label()
        if let promptKey {
            let text = Localizer.string(promptKey, locale: Self.locale)
            self.prompt = text
        }
    }

    /// Makes this field required for form submission.
    /// - Returns: A modified text field marked as required.
    public func required() -> Self {
        var copy = self
        copy.attributes.append(customAttributes: .required)
        return copy
    }

    /// Sets the `HTML` `id` attribute of the input, and the `for` attribute of the label.
    /// - Parameter id: The HTML ID value to set
    /// - Returns: A modified copy of the element with the HTML id added
    public func id(_ id: String) -> Self {
        var copy = self
        copy.id = id
        return copy
    }

    /// Disables this field, preventing user interaction.
    /// - Returns: A modified text field in a disabled state.
    public func disabled() -> Self {
        var copy = self
        copy.attributes.append(customAttributes: .disabled)
        return copy
    }

    /// Makes this field read-only with a predetermined value.
    /// - Parameters:
    ///   - value: The value to display in the field.
    ///   - displayMode: How the read-only field should be presented.
    /// - Returns: A modified text field in a read-only state.
    public func readOnly(_ value: String, displayMode: ReadOnlyDisplayMode = .automatic) -> Self {
        var copy = self
        copy.attributes.append(customAttributes: .readOnly)
        copy.attributes.append(customAttributes: .init(name: "value", value: value))
        return copy
    }

    /// Sets the input type to control validation and keyboard appearance.
    /// - Parameter type: The type of input this field will collect.
    /// - Returns: A modified text field configured for the specified input type.
    public func textContentType(_ type: TextContentType) -> Self {
        var copy = self
        copy.textFieldType = type
        return copy
    }

    /// Sets how the label is displayed relative to the input field.
    /// - Parameter style: The style determining label placement.
    /// - Returns: A modified text field with the specified label style.
    public func labelStyle(_ style: ControlLabelStyle) -> Self {
        var copy = self
        copy.style = style
        return copy
    }

    public func render() -> Markup {
        var attributes = attributes
        attributes.append(classes: style?.labelClass)
        attributes.append(customAttributes: .init(name: "type", value: textFieldType.rawValue))
        attributes.id = self.id

        let controlLabelStyle = style ?? BuildContext.current.controlLabelStyle ?? .leading

        // When labels are hidden with no prompt, we'll attempt to use the label's
        // text for both placeholder and aria-label, assuming only the String
        // initializer was used for accessibility.
        let labelText = label as? String

        if let prompt {
            attributes.append(customAttributes: .init(name: "placeholder", value: prompt))
        } else if case .hidden = controlLabelStyle, let labelText {
            attributes.append(customAttributes: .init(name: "placeholder", value: labelText))
        }

        return switch controlLabelStyle {
        case .hidden:
            Input()
                .attributes(attributes)
                .aria(.label, labelText)
                .render()

        default:
            Section {
                Section {
                    if let label {
                        ControlLabel(label)
                            .attribute("for", id)
                    }
                }
                .class("field-label")

                Section {
                    Input()
                        .attributes(attributes)
                }
                .class("field-control")
            }
            .class("form-field")
            .render()
        }
    }
}
