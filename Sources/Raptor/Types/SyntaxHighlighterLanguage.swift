//
// SyntaxHighlighter.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// The collection of syntax highlighters supported by Raptor.
public enum SyntaxHighlighterLanguage: String, Sendable, Hashable, Equatable {
    case appleScript = "applescript"
    case bash
    case c // swiftlint:disable:this identifier_name
    case cLike = "clike"
    case cPlusPlus = "cpp"
    case cSharp = "csharp"
    case css
    case dart
    case git
    case go // swiftlint:disable:this identifier_name
    case html
    case java
    case javaScript = "javascript"
    case json
    case kotlin
    case markdown
    case markup = "xml"
    case markupTemplating = "template"
    case objectiveC = "objectivec"
    case perl
    case php
    case python
    case ruby
    case rust
    case sql
    case swift
    case outline = "treeview"
    case typeScript = "typescript"
    case webAssembly = "wasm"
    case yaml

    var dependency: SyntaxHighlighterLanguage? {
        switch self {
        case .c: .cLike
        case .cPlusPlus: .c
        case .cSharp: .cLike
        case .dart: .cLike
        case .go: .cLike
        case .java: .cLike
        case .javaScript: .cLike
        case .kotlin: .cLike
        case .markdown: .markup
        case .objectiveC: .c
        case .ruby: .cLike
        case .typeScript: .javaScript
        default: nil
        }
    }
}
