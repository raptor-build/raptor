//
// SyntaxHighlightGenerator.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

struct SyntaxHighlightGenerator {
    var highlighters = OrderedSet<SyntaxHighlighterLanguage>()

    func generateSyntaxHighlighters() -> String {
        var result = ""
        var highlighters = highlighters.sorted(by: { $0.rawValue < $1.rawValue })
        var highlightersCount = 0

        // A lazy way to recursively scan through dependencies
        repeat {
            highlightersCount = highlighters.count
            let dependencies = highlighters.compactMap(\.dependency)
            for dependency in dependencies where !highlighters.contains(dependency) {
                highlighters.append(dependency)
            }
        } while highlightersCount != highlighters.count

        var filenames = highlighters.map { "Resources/js/prism/prism-\($0.rawValue.lowercased())" }
        filenames.append("Resources/js/prism/prism-core")

        // Add our highlighters in reverse order, so dependencies are added first
        for filename in filenames.reversed() {
            guard let url = Bundle.module.url(forResource: filename, withExtension: "js") else {
                BuildContext.logError(.missingSyntaxHighlighter(filename))
                continue
            }
            guard let contents = try? String(contentsOf: url, encoding: .utf8) else {
                BuildContext.logError(.failedToLoadSyntaxHighlighter(filename))
                continue
            }
            result += contents
        }

        return result
    }
}
