//
//  CodeBlock.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `CodeBlock` element.
@Suite("CodeBlock Tests")
struct CodeBlockTests {
    @Test("Rendering a code block")
    func codeBlockTest() {
        let element = CodeBlock { """
        import Foundation
        struct CodeBlockTest {
            let name: String
        }
        let test = CodeBlockTest(name: "Swift")
        """ }

        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        #expect(output == """
        <pre><code>import Foundation
        struct CodeBlockTest {
            let name: String
        }
        let test = CodeBlockTest(name: "Swift")</code></pre>
        """)
    }
}
