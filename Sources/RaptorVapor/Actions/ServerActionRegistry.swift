//
// ServerActionRegistry.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

/// A global registry used to track all `ServerAction` types available
/// within the running application.
///
/// Raptor registers action types during page rendering, and the Vapor
/// integration resolves incoming requests using this registry.
/// This type is internal to the framework and never exposed publicly.
actor ServerActionRegistry {
    /// Shared global instance used by the framework.
    static let shared = ServerActionRegistry()

    /// Lookup table mapping action identifiers to their concrete types.
    private var map: [String: any ServerAction.Type] = [:]

    /// Registers a `ServerAction` type so that it may later be looked up
    /// by its `endpoint` and executed by the action router.
    func register(_ type: any ServerAction.Type) {
        map[type.endpoint] = type
    }

    /// Returns the registered `ServerAction` type for a given identifier,
    /// or `nil` if no such action has been registered.
    func lookup(_ id: String) -> (any ServerAction.Type)? {
        map[id]
    }
}

extension Application {
    /// Registers a server action type in the global registry.
    /// - Parameter type: The action type being registered.
    func register<A: ServerAction>(_ type: A.Type) async {
        await ServerActionRegistry.shared.register(type)
    }
}
