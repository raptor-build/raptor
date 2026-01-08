//
// FeedLink.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Displays a link to your RSS feed, if enabled.
public struct FeedLink: HTML {
    @Environment(\.feedConfiguration) private var feedConfig

    public var body: some HTML {
        if let feedConfig {
            Text {
                Image(systemName: "rss-fill")
                    .foregroundStyle(.orange)
                    .margin(.trailing, 10)
                Link("RSS Feed", destination: feedConfig.path)
                EmptyInlineContent()
            }
            .horizontalAlignment(.center)
        }
    }
}
