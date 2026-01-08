//
// Button+ServerAction.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

public extension Button {
    /// Creates a button whose tap triggers a server-side action.
    ///
    /// This initializer wraps the supplied `ServerAction` in an internal
    /// JavaScript-triggering action so that pressing the button performs:
    ///
    ///     POST /_actions/<endpoint>
    ///
    /// with the action encoded as JSON.
    ///
    /// - Parameters:
    ///   - titleKey: Localized title of the button.
    ///   - action: A concrete server action instance to execute.
    init<A: ServerAction>(
        _ titleKey: String,
        action: A
    ) where Label == String {
        let csrf = ActiveRequest.current?.csrfToken ?? ""
        let jsAction = (try? ServerActionJS(action, csrfToken: csrf)) ?? ServerActionJS.fallback()
        self.init(titleKey, action: jsAction)
    }

    /// Creates a button whose tap triggers a server-side action.
    ///
    /// Same as the string initializer, but allows the label to be a
    /// full inline element rather than a simple string.
    ///
    /// - Parameters:
    ///   - action: The server action to perform.
    ///   - label: Builder producing the inline element shown inside the button.
    init<A: ServerAction>(
        action: A,
        @InlineContentBuilder label: () -> Label
    ) {
        let csrf = ActiveRequest.current?.csrfToken ?? ""
        let jsAction = (try? ServerActionJS(action, csrfToken: csrf)) ?? ServerActionJS.fallback()
        // swiftlint:disable:next force_cast
        self.init(action: jsAction, label: label() as! () -> Label)
    }
}
