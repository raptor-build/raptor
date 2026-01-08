//
// ScriptModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Adds a script file that will be loaded when the page is displayed.
    /// - Parameter file: The path or URL of the script to load.
    /// - Returns: A modified `Main` that includes the script.
    @HTMLBuilder func script(_ file: String) -> some HTML {
        self
        Script(file: file)
    }

    /// Adds custom JavaScript that will run when the page loads.
    /// - Parameter code: The JavaScript source to include.
    /// - Returns: A modified `Main` that includes the script.
    @HTMLBuilder func script(code: String) -> some HTML {
        self
        Script(code: code)
    }

    /// Adds an external script with configurable loading behavior.
    /// - Parameters:
    ///   - file: The script file to load.
    ///   - configure: A closure for customizing how the script loads.
    /// - Returns: A modified `Main` that includes the configured script.
    @HTMLBuilder func script(
        _ file: String,
        configure: (ScriptConfiguration) -> ScriptConfiguration
    ) -> some HTML {
        self
        let config = configure(ScriptConfiguration(file: file))
        Script(config)
    }

    /// Adds inline JavaScript with configurable loading behavior.
    /// - Parameters:
    ///   - code: The JavaScript to embed.
    ///   - configure: A closure for customizing how the script loads.
    /// - Returns: A modified `Main` that includes the configured script.
    @HTMLBuilder func script(
        code: String,
        configure: (ScriptConfiguration) -> ScriptConfiguration
    ) -> some HTML {
        self
        let config = configure(ScriptConfiguration(code: code))
        Script(config)
    }
}

public extension InlineContent {
    /// Adds a script file that will be loaded when the page is displayed.
    /// - Parameter file: The path or URL of the script to load.
    /// - Returns: A modified `Main` that includes the script.
    @HTMLBuilder func script(_ file: String) -> some HTML {
        self
        Script(file: file)
    }

    /// Adds custom JavaScript that will run when the page loads.
    /// - Parameter code: The JavaScript source to include.
    /// - Returns: A modified `Main` that includes the script.
    @HTMLBuilder func script(code: String) -> some HTML {
        self
        Script(code: code)
    }

    /// Adds an external script with configurable loading behavior.
    /// - Parameters:
    ///   - file: The script file to load.
    ///   - configure: A closure for customizing how the script loads.
    /// - Returns: A modified `Main` that includes the configured script.
    @HTMLBuilder func script(
        _ file: String,
        configure: (ScriptConfiguration) -> ScriptConfiguration
    ) -> some HTML {
        self
        let config = configure(ScriptConfiguration(file: file))
        Script(config)
    }

    /// Adds inline JavaScript with configurable loading behavior.
    /// - Parameters:
    ///   - code: The JavaScript to embed.
    ///   - configure: A closure for customizing how the script loads.
    /// - Returns: A modified `Main` that includes the configured script.
    @HTMLBuilder func script(
        code: String,
        configure: (ScriptConfiguration) -> ScriptConfiguration
    ) -> some HTML {
        self
        let config = configure(ScriptConfiguration(code: code))
        Script(config)
    }
}
