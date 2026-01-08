//
// CustomAction.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Allows the user to inject hand-written JavaScript into an event. The code you provide
/// will automatically be escaped.
public struct CustomAction: Action {
    /// The JavaScript code to execute.
    private var code: String

    /// Creates a new CustomAction action from the provided JavaScript code.
    /// - Parameter code: The code to execute.
    public init(_ code: String) {
        self.code = code
    }

    /// Renders this action into JS.
    /// - Returns: The JavaScript for this action.
    public func compile() -> String {
        code.escapedForJavascript()
    }
}

public extension Action where Self == CustomAction {
    /// Creates a new `CustomAction` that executes custom JavaScript code
    /// - Parameter code: The JavaScript code to execute
    /// - Returns: A `CustomAction` configured with the specified JavaScript code
    static func custom(_ code: String) -> Self {
        CustomAction(code)
    }
}
