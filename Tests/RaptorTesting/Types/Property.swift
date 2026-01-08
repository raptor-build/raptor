//
//  Property.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Property` type.
@Suite("Property Tests")
struct PropertyTests {
    @Test("Description for property string initializer")
    func descriptionPropertyStringInit() throws {
        let example: Property = .fontSize(.px(25))
        #expect(example.description == "font-size: 25px")
    }

    static let stylePairs: [(lhs: Property, rhs: Property)] = [
        (.position(.absolute), .backgroundColor(.currentColor)),
        (.color(.transparent), .textAlign(.center))
    ]

    static let comparisonResults: [Bool] = [
        false,  // position < backgroundColor
        true   // color > textAlign
    ]

    @Test("Comparable operator", arguments: zip(stylePairs, comparisonResults))
    func comparable(_ pair: (lhs: Property, rhs: Property), lessThan: Bool) throws {
        #expect((pair.lhs < pair.rhs) == lessThan)
        #expect((pair.lhs > pair.rhs) == !lessThan)
    }
}
