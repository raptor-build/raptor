//
// ShowAlert.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Shows a browser alert dialog with an OK button.
public struct ShowAlert: Action {
    /// The text to show inside the alert
    private let message: String

    /// Creates a new `ShowAlert` action with its message string.
    /// - Parameter message: The message text to show in the alert.
    public init(message: String) {
        self.message = message
    }

    /// Renders this action into JS.
    /// - Returns: The JavaScript for this action.
    public func compile() -> String {
        "alert('\(message.escapedForJavascript())')"
    }
}

public extension Action where Self == ShowAlert {
    /// Creates a new `ShowAlert` action
    /// - Parameter message: The text to show inside the alert
    /// - Returns: A `ShowAlert` action configured with the specified message
    static func showAlert(message: String) -> Self {
        ShowAlert(message: message)
    }
}
