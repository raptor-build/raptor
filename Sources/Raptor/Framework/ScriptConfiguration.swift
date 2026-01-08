//
// ScriptConfiguration.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public struct ScriptConfiguration: Sendable {
    enum Payload: Sendable {
        case file(String)
        case code(String)
    }

    init(file: String) {
        self.payload = .file(file)
    }

    init(code: String) {
        self.payload = .code(code)
    }

    var attributes: CoreAttributes = .init()

    var payload: Payload

    /// Marks the script for asynchronous loading (`async`).
    public func async() -> Self {
        var copy = self
        copy.attributes.append(customAttributes: .init("async"))
        return copy
    }

    /// Marks the script for deferred execution (`defer`).
    public func `defer`() -> Self {
        var copy = self
        copy.attributes.append(customAttributes: .init("defer"))
        return copy
    }

    /// Sets the script integrity hash (`integrity="sha256-..."`).
    public func integrity(_ value: String) -> Self {
        var copy = self
        copy.attributes.append(customAttributes: .init(name: "integrity", value: value))
        return copy
    }

    /// Sets the script crossorigin mode.
    public func crossOrigin(_ mode: CrossOrigin) -> Self {
        var copy = self
        copy.attributes.append(customAttributes: .init(name: "crossorigin", value: mode.rawValue))
        return copy
    }

    /// Sets the fetch priority (`fetchpriority="high|low|auto"`).
    public func fetchPriority(_ value: FetchPriority) -> Self {
        var copy = self
        copy.attributes.append(customAttributes: .init(name: "fetchpriority", value: value.rawValue))
        return copy
    }

    /// Adds any custom script attribute.
    public func attribute(_ name: String, _ value: String) -> Self {
        var copy = self
        copy.attributes.append(customAttributes: .init(name: name, value: value))
        return copy
    }
}

public enum CrossOrigin: String, Sendable {
    case anonymous
    case useCredentials = "use-credentials"
}

public enum FetchPriority: String, Sendable {
    case high
    case low
    case automatic = "auto"
}
