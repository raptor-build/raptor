//
// PostPageContent.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

struct PostPageContent: HTML {
    var body: Never { fatalError() }
    var attributes = CoreAttributes()
    private var content: any HTML

    init(_ content: any HTML) {
        self.content = content
    }

    func render() -> Markup {
        Markup("<article>\(content.markupString())</article>")
    }
}
