//
//  Material.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Material` type.
@Suite("Material Tests")
struct MaterialTests {
    @Test("Correct class name without color scheme.", arguments: [
        (Material.ultraThinMaterial, "ultra-thin"),
        (Material.thinMaterial, "thin"),
        (Material.regularMaterial, "regular"),
        (Material.thickMaterial, "thick"),
        (Material.ultraThickMaterial, "ultra-thick")
    ])
    func className(material: Material, type: String) {
        #expect(material.className == "material-\(type)")
    }
}
