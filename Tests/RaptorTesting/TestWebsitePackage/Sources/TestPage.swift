//
// TestPage.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Raptor

/// An example page used in tests.
struct TestPage: Page, @unchecked Sendable {
    var title = "Home"

    var body: some HTML {
        Text("Hello, World!")
    }
}
