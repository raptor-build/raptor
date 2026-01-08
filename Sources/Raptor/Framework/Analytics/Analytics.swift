//
// AnalyticsSnippet.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Embeds analytics tracking code in the page head section for various analytics services.
struct Analytics: HeadContent {
    /// The standard set of control attributes for HTML elements.
    var attributes = CoreAttributes()

    /// The analytics service to use
    private let service: AnalyticsService

    /// Creates a new analytics snippet for the specified service
    /// - Parameter service: The analytics service to configure
    init(_ service: AnalyticsService) {
        self.service = service
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    func render() -> Markup {
        switch service {
        case .google(let measurementID):
            Markup(googleAnalyticsCode(for: measurementID))

        case .plausible(let siteID):
            Markup(plausibleCode(for: siteID))

        case .fathom(let siteID):
            Markup(fathomCode(for: siteID))

        case .clicky(let siteID):
            Markup(clickyCode(for: siteID))

        case .telemetryDeck(let siteID):
            Markup(telemetryDeckCode(for: siteID))

        case .custom(let code):
            Markup(code)
        }
    }

    /// Creates Clicky analytics code for the current site.
    /// - Parameter siteID: This site's Clicky identifier.
    /// - Returns: HTML for analytics tracking.
    func clickyCode(for siteID: String) -> String {
        """
        <!-- Clicky Analytics -->
        <script>var clicky_site_ids = clicky_site_ids || []; clicky_site_ids.push(\(siteID));</script>
        <script async src="//static.getclicky.com/js"></script>
        """
    }

    /// Creates Fathom analytics code for the current site.
    /// - Parameter siteID: This site's Fathom identifier.
    /// - Returns: HTML for analytics tracking.
    func fathomCode(for siteID: String) -> String {
        """
        <!-- Fathom Analytics -->
        <script src="https://cdn.usefathom.com/script.js" data-site="\(siteID)" defer></script>
        """
    }

    /// Creates Google Analytics code for the current site.
    /// - Parameter measurementID: This site's Google Analytics identifier.
    /// - Returns: HTML for analytics tracking.
    func googleAnalyticsCode(for measurementID: String) -> String {
        """
        <!-- Google Analytics 4 -->
        <script async src="https://www.googletagmanager.com/gtag/js?id=G-\(measurementID)"></script>
        <script>
            window.dataLayer = window.dataLayer || [];
            function gtag(){dataLayer.push(arguments);}
            gtag('js', new Date());
            gtag('config', '\(measurementID)');
        </script>
        """
    }

    /// Creates Plausible analytics code for the current site.
    /// - Parameter domain: This site's domain.
    /// - Parameter measurements: The set of items the user is tracking.
    /// - Returns: HTML for analytics tracking.
    func plausibleCode(for siteID: String) -> String {
        """
        <!-- Privacy-friendly analytics by Plausible -->
        <script async src="https://plausible.io/js/pa-\(siteID).js"></script>
        <script>
            window.plausible = window.plausible || function() {
                (plausible.q = plausible.q || []).push(arguments)
            };
            plausible.init = plausible.init || function(i) { plausible.o = i || {} };
            plausible.init();
        </script>
        """
    }

    /// Creates TelemetryDeck analytics code for the current site.
    /// - Parameter siteID: This site's TelemetryDeck identifier.
    /// - Returns: HTML for analytics tracking.
    func telemetryDeckCode(for siteID: String) -> String {
        """
        <!-- TelemetryDeck Analytics -->
        <script
            src="https://cdn.telemetrydeck.com/websdk/telemetrydeck.min.js"
            data-app-id="\(siteID)"
        ></script>
        """
    }
}
