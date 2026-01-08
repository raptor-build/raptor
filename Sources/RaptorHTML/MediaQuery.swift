//
// MediaQuery.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents a CSS media query with nested declarations
package struct MediaQuery: CSS {
    package enum Combinator: String {
        case and = ") and ("
        case or = ") or (" // swiftlint:disable:this identifier_name
    }

    /// The media features to check
    var features: [MediaFeature]

    /// How the features should be combined
    var combinator: Combinator

    /// The nested rulesets within this media query
    var rulesets: [Ruleset]

    package init(
        _ features: MediaFeature...,
        combinator: Combinator = .and,
        @RulesetBuilder rulesets: () -> [Ruleset]
    ) {
        self.features = features
        self.combinator = combinator
        self.rulesets = rulesets()
    }

    package init(
        _ features: [MediaFeature],
        combinator: Combinator = .and,
        @RulesetBuilder rulesets: () -> [Ruleset]
    ) {
        self.features = features
        self.combinator = combinator
        self.rulesets = rulesets()
    }

    package init(
        _ features: [MediaFeature],
        combinator: Combinator = .and,
        rulesets: some Collection<Ruleset>
    ) {
        self.features = features
        self.combinator = combinator
        self.rulesets = Array(rulesets)
    }

    package func render() -> String {
        let query = features.map(\.description).joined(separator: combinator.rawValue)
        let rulesBlock = rulesets.map { $0.render() }.joined(separator: "\n\n")

        return """
        @media (\(query)) {
            \(rulesBlock)
        }
        """
    }
}
