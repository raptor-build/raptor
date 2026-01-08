//
// AnalyticsService.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the different analytics integrations supported by Raptor.
public enum AnalyticsService: Sendable {
    /// Adds support for Google Analytics 4.
    /// - Parameter measurementID: The Measurement ID without the `"G-"` prefix.
    case google(measurementID: String)

    /// Adds support for Plausible Analytics.
    /// - Parameter siteID: The Plausible site identifier without the `"pa-"` prefix.
    case plausible(siteID: String)

    /// Adds support for Fathom Analytics.
    /// - Parameter siteID: The ID assigned to your Fathom site (e.g. `"ABCDEF12"`).
    case fathom(siteID: String)

    /// Adds support for Clicky Analytics.
    /// - Parameter siteID: The numeric Clicky site ID (e.g. `"123456789"`).
    case clicky(siteID: String)

    /// Adds support for TelemetryDeck.
    /// - Parameter siteID: Your TelemetryDeck App ID (e.g. `"123e4567-e89b-12d3-a456-426614174000"`).
    case telemetryDeck(siteID: String)

    /// Embeds a fully custom analytics script.
    /// - Parameter code: A raw `<script>` block or JavaScript code string.
    case custom(_ code: String)
}
