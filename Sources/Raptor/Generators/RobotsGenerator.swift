//
// RobotsGenerator.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

struct RobotsGenerator: Sendable {
    var site: SiteContext

    func generateRobots() -> String {
        let disallowRules = site.robotsConfiguration.disallowRules.map { rule in
            var ruleText = "User-agent: \(rule.name)\n"

            ruleText += rule.paths.map {
                "Disallow: \($0)\n"
            }.joined()

            return "\(ruleText)\n"
        }.joined()

        let result = """
        \(disallowRules)\
        User-agent: *
        Allow: /

        Sitemap: \(site.url.absoluteString)/sitemap.xml
        """

        return result
    }
}
