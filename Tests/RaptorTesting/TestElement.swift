//
// TestElement.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

@testable import Raptor

private struct TestSubElement: HTML {
    var body: some HTML {
        Text("Test Heading!")
    }
}

/// A custom element that modifiers can test.
struct TestElement: HTML {
    var body: some HTML {
        TestSubElement()
        Text("Test Subheading")
        ControlLabel("Test Label")
    }
}
