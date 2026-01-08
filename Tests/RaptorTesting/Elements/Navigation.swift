//
// Navigation.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Testing

@testable import Raptor

/// Tests for the `Navigation` element.
@Suite("Navigation Tests")
struct NavigationTests {
    @Test("Root tag is nav")
    func navTag() throws {
        let element = Navigation {}
        let output = withTestRenderingEnvironment {
            element.render().string
        }

        #expect(output.htmlTagWithCloseTag("nav") != nil)
    }

    @Test("Nav tag class is navbar")
    func navTagClass() throws {
        let element = Navigation {}
        let output = withTestRenderingEnvironment {
            element.render().string
        }

        let navClasses = try #require(output
            .htmlTagWithCloseTag("nav")?.attributes
            .htmlAttribute(named: "class")?
            .components(separatedBy: " ")
        )

        let expected = ["navbar"]
        #expect(navClasses == expected)
    }

    @Test("Navigation contains sizing class", arguments: NavigationBarSizing.allCases)
    func navigation_contains_sizing_class(sizing: NavigationBarSizing) throws {
        let element = Navigation {}
            .navigationBarSizing(sizing)

        let output = withTestRenderingEnvironment {
            element.render().string
        }

        #expect(output.contains(sizing.rawValue))
    }

    @Test("Div tag contains unordered list if items is not nil")
    func divTagContainsUL() async throws {
        try await withTestRenderingEnvironment {
            let item = Link("Link 1", destination: URL(string: "1")!)
            let element = Navigation {
                item
            }

            let output = withTestRenderingEnvironment {
                element.render().string
            }

            let divContents = try #require(output
                .htmlTagWithCloseTag("nav")?.contents)

            #expect(divContents.htmlTagWithCloseTag("ul") != nil)
        }
    }

    @Test("UL tag contains rendered output of navigation item")
    func divTagContainsRenderedItem() async throws {
        try await withTestRenderingEnvironment {
            let item = Link("Link 1", destination: URL(string: "1")!)
            let element = Navigation {
                item
            }

            let output = withTestRenderingEnvironment {
                element.render().string
            }

            let ulContents = try #require(output
                .htmlTagWithCloseTag("nav")?.contents
                .htmlTagWithCloseTag("ul")?.contents)

            let expectedLink = item.render().string
            let expectedNavItem = "<li>\(expectedLink)</li>"

            #expect(ulContents.contains(expectedNavItem))
        }
    }

    @Test("UL Tag contains rendered output of navigation items")
    func divTagContainsRenderedItems() async throws {
        try await withTestRenderingEnvironment {
            let item1 = Link("Link 1", destination: URL(string: "1")!)
            let item2 = Link("Link 2", destination: URL(string: "2")!)
            let element = Navigation {
                item1
                item2
            }

            let output = withTestRenderingEnvironment {
                element.render().string
            }

            let ulContents = try #require(output
                .htmlTagWithCloseTag("nav")?.contents
                .htmlTagWithCloseTag("ul")?.contents)

            let expectedLink1 = item1.render().string
            let expectedNavItem1 = "<li>\(expectedLink1)</li>"

            let expectedLink2 = item2.render().string
            let expectedNavItem2 = "<li>\(expectedLink2)</li>"

            #expect(ulContents.contains(expectedNavItem1))
            #expect(ulContents.contains(expectedNavItem2))
        }
    }
}
