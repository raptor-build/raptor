//
// TestStory.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Raptor

struct TestStory: PostPage {
    var body: some HTML {
        post.text
    }
}
