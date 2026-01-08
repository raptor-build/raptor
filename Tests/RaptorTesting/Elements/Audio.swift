//
// Audio.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Audio` element.
@Suite("Audio Tests")
struct AudioTests {
    @Test("Lone File Audio", arguments: ["/audio/example.mp3"])
    func loneFileAudio(audioFile: String) {
        let element = Audio(audioFile)
        let output = element.markupString()

        #expect(output == """
        <audio controls>\
        <source src="\(audioFile)" type="audio/mpeg">Your browser does not support the audio element.\
        </audio>
        """)
    }

    @Test("Multiple File Audio", arguments: ["/audio/example1.mp3"], ["/audio/example1.wav"])
    func multiFileAudio(audioFile1: String, audioFile2: String) {
        let element = Audio(audioFile1, audioFile2)
        let output = element.markupString()

        #expect(output == """
        <audio controls>\
        <source src="\(audioFile1)" type="audio/mpeg">\
        <source src="\(audioFile2)" type="audio/wav">Your browser does not support the audio element.\
        </audio>
        """)
    }
}
