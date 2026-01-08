//
//  Menu.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Dropdown` element.
@Suite("Menu Tests")
struct MenuTests {
    @Test("Basic Menu Text")
    func basicDropdownText() {
        let element = Menu("Click Me") {
            Text("Content1")
            Text("Content2")
            Text("Or you can just…")
        }

        let output = withTestRenderingEnvironment {
            element.render().string
        }

        let expectedOutput = #"""
        <div class="menu btn">
            <button type="button" class="btn-menu btn" data-toggle="dropdown">Click Me</button>
            <ul class="menu-dropdown material-ultra-thick">
                <li><p>Content1</p></li>
                <li><p>Content2</p></li>
                <li><p>Or you can just…</p></li>
            </ul>
        </div>
        """#

        let normalizedOutput = output.replacingOccurrences(
            of: "\\s+", with: "", options: .regularExpression
        )
        let normalizedExpectedOutput = expectedOutput.replacingOccurrences(
            of: "\\s+", with: "", options: .regularExpression
        )

        #expect(normalizedOutput == normalizedExpectedOutput)
    }

    @Test("Empty Menu")
    func emptyDropdown() {
        let element = Menu("Click Me") {}

        let output = withTestRenderingEnvironment {
            element.render().string
        }

        let expectedOutput = #"""
        <div class="menu btn">
            <button type="button" class="btn-menu btn" data-toggle="dropdown">Click Me</button>
            <ul class="menu-dropdown material-ultra-thick"></ul>
        </div>
        """#

        let normalizedOutput = output.replacingOccurrences(
            of: "\\s+", with: "", options: .regularExpression
        )
        let normalizedExpectedOutput = expectedOutput.replacingOccurrences(
            of: "\\s+", with: "", options: .regularExpression
        )

        #expect(normalizedOutput == normalizedExpectedOutput)
    }
}
