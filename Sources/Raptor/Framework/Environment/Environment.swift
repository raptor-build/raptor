//
// Environment.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A property wrapper that provides access to values from the environment.
///
/// Use `Environment` to read values that are propagated through your site's view hierarchy. For example:
///
/// ```swift
/// struct ContentView: HTMLRootElement {
///     @Environment(\.themes) var themes
/// }
/// ```
@propertyWrapper
public struct Environment<Value> {
    /// The key path to the desired environment value.
    private let keyPath: KeyPath<EnvironmentValues, Value>

    /// Reads the current value from the task-local environment.
    public var wrappedValue: Value {
        guard let values = RenderingContext.current?.environment else {
            fatalError("@Environment accessed outside of rendering")
        }
        return values[keyPath: keyPath]
    }

    /// Creates an environment property for the given key path.
    /// - Parameter keyPath: A key path selecting the desired environment value.
    public init(_ keyPath: KeyPath<EnvironmentValues, Value>) {
        self.keyPath = keyPath
    }
}
