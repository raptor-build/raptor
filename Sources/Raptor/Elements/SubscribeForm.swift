//
// SubscribeForm.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A form for collecting email addresses for newsletter subscriptions.
public struct SubscribeForm: HTML {
    /// Defines the layout arrangement of form elements.
    public enum FormStyle: Sendable {
        /// Elements are arranged horizontally in a single row.
        case inline
        /// Elements are stacked vertically.
        case stacked
    }

    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The email platform that will receive form submissions.
    private let service: EmailPlatform

    /// The text displayed on the subscription button.
    private var subscribeButtonLabel = "Subscribe"

    /// The label text for the email input field.
    private var emailFieldLabel = "Email"

    /// The layout arrangement for form elements.
    private var formStyle: FormStyle = .inline

    /// Creates a new form with the specified spacing and content.
    /// - Parameter service: The newsletter service provider.
    public init(_ service: EmailPlatform) {
        self.service = service

        attributes.append(customAttributes: .init(name: "method", value: "post"))
        attributes.append(customAttributes: .init(name: "target", value: "_blank"))
        attributes.append(customAttributes: .init(name: "action", value: service.endpoint))
        attributes.data.formUnion(service.dataAttributes)
        attributes.customAttributes.formUnion(service.customAttributes)
        attributes.append(classes: service.formClass)

        switch service {
        case .mailchimp:
            attributes.id = "mc-embedded-subscribe-form"
        case .sendFox(_, let formID):
            attributes.id = formID
        default:
            attributes.id = UUID().uuidString.truncatedHash
        }
    }

    /// Sets the text displayed on the subscribe button.
    /// - Parameter label: The text to display on the button.
    /// - Returns: A modified form with the updated button text.
    public func subscribeButtonLabel(_ label: String) -> Self {
        var copy = self
        copy.subscribeButtonLabel = label
        return copy
    }

    /// Sets the label for the email input field.
    /// - Parameter label: The text to use as the email field label.
    /// - Returns: A modified form with the updated field label.
    public func emailFieldLabel(_ label: String) -> Self {
        var copy = self
        copy.emailFieldLabel = label
        return copy
    }

    /// Sets the arrangement of form elements.
    /// - Parameter style: The layout style to apply to the form.
    /// - Returns: A modified form with the specified layout style.
    public func formStyle(_ style: FormStyle) -> Self {
        var copy = self
        copy.formStyle = style
        return copy
    }

    @HTMLBuilder private var formContent: some HTML {
        TextField(emailFieldLabel, prompt: emailFieldLabel)
            .textContentType(.text)
            .id(service.emailFieldID)
            .customAttribute(name: "name", value: service.emailFieldName!)
            .class("w-100")

        Button(subscribeButtonLabel, role: .submit)
            .class("w-100")

        if let honeypotName = service.honeypotFieldName {
            Section {
                TextField("", prompt: nil)
                    .labelStyle(.hidden)
                    .id("")
                    .customAttribute(name: "name", value: honeypotName)
                    .customAttribute(name: "tabindex", value: "-1")
                    .customAttribute(name: "value", value: "")
                    .customAttribute(name: "autocomplete", value: "off")
            }
            .customAttribute(name: "style", value: "position: absolute; left: -5000px;")
            .customAttribute(name: "aria-hidden", value: "true")
        }
    }

    public func render() -> Markup {
        var formOutput = if formStyle == .stacked {
            Form {
                formContent
            }
            .labelStyle(.hidden)
            .class("subscribe-form")
            .attributes(attributes)
            .render()
        } else {
            GridForm(columns: [.flexible, .automatic]) {
                formContent
            }
            .labelStyle(.hidden)
            .attributes(attributes)
            .render()
        }

        if let script = service.script {
            formOutput += Script(file: URL(static: script))
                .customAttribute(name: "charset", value: "utf-8")
                .render()
        }

        return formOutput
    }
}
