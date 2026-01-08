//
//  Grid.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Grid` element.
@Suite("Grid Tests")
struct GridTests {
    private func extractGridItems(_ html: String) -> [String] {
        let regex = /<[^>]+class="[^"]*\bgrid-item\b[^"]*"[^>]*>/

        return html
            .matches(of: regex)
            .map { String($0.output) }
    }

    private func extractGridTemplate(_ html: String) -> String {
        let regex = /--grid-template:\s*([^;"]+)/

        return html
            .firstMatch(of: regex)
            .map { String($0.1) }
            ?? ""
    }

    @Test("Grid with three implicit items produces one column")
    func gridWithThreeImplicitItems() {
        let element = Grid {
            Image("a", description: "A").resizable()
            Image("b", description: "B").resizable()
            Image("c", description: "C").resizable()
        }

        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        let items = extractGridItems(output)

        #expect(extractGridTemplate(output) == "1fr")
        #expect(items.count == 3)
    }

    @Test("Grid with explicit rows flattens items without wrappers")
    func gridWithExplicitRows() {
        let element = Grid {
            GridRow {
                Image("a", description: "A").resizable()
                Image("b", description: "B").resizable()
            }
            GridRow {
                Image("c", description: "C").resizable()
                Image("d", description: "D").resizable()
            }
        }

        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        let items = extractGridItems(output)

        #expect(extractGridTemplate(output) == "1fr 1fr")
        #expect(items.count == 4)
    }

    @Test("Implicit full-width item spans inferred columns")
    func gridImplicitFullWidthItem() {
        let element = Grid {
            GridRow {
                Text("A")
                Text("B")
            }
            Text("C")
        }

        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        let template = extractGridTemplate(output)
        #expect(template == "1fr 1fr")

        let items = extractGridItems(output)
        #expect(items.count == 3)

        // First row items: no spans
        #expect(!items[0].contains("grid-column"))
        #expect(!items[1].contains("grid-column"))

        // Implicit item spans full width
        #expect(items[2].contains("grid-column: span 2"))
    }

    @Test("Explicit span defines full-width row")
    func gridExplicitFullWidthRow() {
        let element = Grid {
            GridRow {
                Text("A")
                Text("B")
            }
            GridRow {
                Text("C").gridCellColumns(2)
            }
        }

        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        let template = extractGridTemplate(output)
        #expect(template == "1fr 1fr")

        let items = extractGridItems(output)
        #expect(items.count == 3)

        // First row items: no spans
        #expect(!items[0].contains("grid-column"))
        #expect(!items[1].contains("grid-column"))

        // Explicit full-width item
        #expect(items[2].contains("grid-column: span 2"))
    }

    @Test("Column count derived from layout, not span sum")
    func gridSpanUsesExistingColumns() {
        let element = Grid {
            GridRow {
                Text("A")
                Text("B").gridCellColumns(2)
            }
        }

        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        let template = extractGridTemplate(output)
        #expect(template == "1fr 1fr 1fr")

        let items = extractGridItems(output)
        #expect(items.count == 2)

        // First item: span 1
        #expect(!items[0].contains("grid-column"))

        // Second item: span 2
        #expect(items[1].contains("grid-column: span 2"))
    }
}
