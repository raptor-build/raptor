//
// DisplayModeQuery.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Applies styles based on the web application's display mode.
public enum DisplayMode: String, Sendable, Hashable, Equatable, CaseIterable {
    /// Standard browser mode
    case browser = "display-mode: browser"
    /// Full screen mode
    case fullscreen = "display-mode: fullscreen"
    /// Minimal UI mode
    case minimalUI = "display-mode: minimal-ui"
    /// Picture-in-picture mode
    case pip = "display-mode: picture-in-picture"
    /// Standalone application mode
    case standalone = "display-mode: standalone"
    /// Window controls overlay mode
    case windowControlsOverlay = "display-mode: window-controls-overlay"
}

extension DisplayMode: MediaFeature {
    package var condition: String {
        rawValue
    }
}

extension MediaFeature where Self == DisplayMode {
    /// Creates a display mode media feature.
    /// - Parameter mode: The display mode to apply.
    /// - Returns: A display mode media feature.
    static func displayMode(_ mode: DisplayMode) -> DisplayMode {
        mode
    }
}

extension DisplayMode: EnvironmentEffectValue {}
