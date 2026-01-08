//
//  Array+LocalizedContains.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Array-LocalizedContains` extension.
@Suite("Array+LocalizedContains Tests")
struct ArrayLocalizedContainsTests {
    @Test("Array contains a matching string")
    func arrayContainsMatchingString() {
        // Given
        let testArray = ["Tom", "Jerry", "Nibbles", "Butch"]
        let searchString1 = "Tom"   // exact match
        let searchString2 = "tom"   // lower cased
        let searchString3 = "TOM"   // uppercased
        let searchString4 = "tOM"   // mixed case
        // When
        let result1 = testArray.localizedContains(searchString1)
        let result2 = testArray.localizedContains(searchString2)
        let result3 = testArray.localizedContains(searchString3)
        let result4 = testArray.localizedContains(searchString4)
        // Then
        #expect(result1 == true)
        #expect(result2 == true)
        #expect(result3 == true)
        #expect(result4 == true)
    }

    @Test("Array does NOT contain a matching string")
    func arrayDoesNotContainMatchingString() {
        // Given
        let testArray = ["Tom", "Jerry", "Nibbles", "Butch"]
        let searchString1 = "toodles"               // no match
        let searchString2 = "Butch and Sundance"    // partial match prefix
        let searchString3 = "Macguire Jerry"        // partial match suffix
        let searchString4 = "Tomas"                 // partial match substring
        // When
        let result1 = testArray.localizedContains(searchString1)
        let result2 = testArray.localizedContains(searchString2)
        let result3 = testArray.localizedContains(searchString3)
        let result4 = testArray.localizedContains(searchString4)
        // Then
        #expect(result1 == false)
        #expect(result2 == false)
        #expect(result3 == false)
        #expect(result4 == false)
    }

    @Test("Strings with diacritics")
    func arrayContainsStringsWithDiacritics() {
        // Given
        let testArray = ["über", "jalapeño", "façade", "naïve"]
        let searchStrings = ["uber", "jalapeno", "facade", "naive"]
        let expectedCount = searchStrings.count
        // When
        var actualCount = 0
        for string in searchStrings where testArray.localizedContains(string) {
            actualCount += 1
        }
        // Then
        #expect(actualCount == expectedCount)
    }

    @Test("Strings with currently unsupported diacritics")
    func arrayContainsUnsupportedDiacritics() {
        // Given
        let testArray = ["łódź", "følg", "zażółć"]
        let searchStrings = ["lodz", "folg", "zazolc"]
        // When
        var actualCount = 0
        for string in searchStrings where testArray.localizedContains(string) {
            actualCount += 1
        }
        // Then
        #expect(actualCount == 0)
    }

    @Test("Strings with special characters")
    func arrayContainsSpecialCharacters() {
        // Given
        let testArray = ["!@#$%^", "&*()_+", "-=~`|", "{[}]\\", ":;\"'<", ">?/.,"]
        let searchStrings = ["!@#$%^", "&*()_+", "-=~`|", "{[}]\\", ":;\"'<", ">?/.,"]
        let expectedCount = searchStrings.count
        // When
        var actualCount = 0
        for string in searchStrings where testArray.localizedContains(string) {
            actualCount += 1
        }
        // Then
        #expect(actualCount == expectedCount)
    }

    @Test("Empty string")
    func usingLocalizedContains_forAnEmptyString() {
        // Given
        let testArray = [" ", "", "", "empty"]
        let searchString = ""
        // When
        let result = testArray.localizedContains(searchString)
        // Then
        #expect(result == false)
    }

    @Test("Array is empty")
    func callingLocalizedContains_onAnEmptyArray() {
        // Given
        let testArray = [String]()
        let searchString = "meaning"
        // When
        let result = testArray.localizedContains(searchString)
        // Then
        #expect(result == false)
    }
}
