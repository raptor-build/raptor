//
//  ListTests.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
@testable import Raptor
import Testing

@Suite("List Rendering & Behavior")
struct ListTests {
    // MARK: - Basic Rendering

    @Test("Empty list renders correctly")
    func emptyList() {
        let list = List {}

        let output = withTestRenderingEnvironment {
            list.markupString()
        }

        #expect(output == #"<ul class="list list-unordered"></ul>"#)
    }

    @Test("Static unordered list renders rows")
    func staticUnorderedList() {
        let list = List {
            "Veni"
            "Vidi"
            "Vici"
        }

        let output = withTestRenderingEnvironment {
            list.markupString()
        }

        #expect(output == """
        <ul class="list list-unordered">\
        <li class="list-row"><div class="list-row-content">Veni</div></li>\
        <li class="list-row"><div class="list-row-content">Vidi</div></li>\
        <li class="list-row"><div class="list-row-content">Vici</div></li>\
        </ul>
        """)
    }

    // MARK: - Ordered Lists

    @Test("Ordered list uses <ol> and ordered marker style")
    func orderedListRendering() {
        let list = List {
            "One"
            "Two"
            "Three"
        }
        .listMarkerStyle(.ordered)

        let output = withTestRenderingEnvironment {
            list.markupString()
        }

        #expect(output.contains("<ol"))
        #expect(output.contains("list-ordered"))
    }

    @Test("Ordered list with custom numbering style")
    func orderedListWithRomanNumerals() {
        let list = List {
            "Alpha"
            "Beta"
        }
        .listMarkerStyle(.ordered(.upperRoman))

        let output = withTestRenderingEnvironment {
            list.markupString()
        }

        #expect(output.contains(#"--list-style-type: upper-roman"#))
    }

    // MARK: - Collection Initializer

    @Test("List generated from collection")
    func listFromCollection() {
        let values = ["Design", "Build", "Test"]

        let list = List(values) { value in
            value
        }

        let output = withTestRenderingEnvironment {
            list.markupString()
        }

        #expect(output.contains("Design"))
        #expect(output.contains("Build"))
        #expect(output.contains("Test"))
    }

    // MARK: - Marker Styles

    @Test("Unordered list with square markers")
    func unorderedListWithSquareMarkers() {
        let list = List {
            "Item"
        }
        .listMarkerStyle(.unordered(.square))

        let output = withTestRenderingEnvironment {
            list.markupString()
        }

        #expect(output.contains(#"--list-marker-content: '▪'"#))
    }

    @Test("Custom marker symbol")
    func customMarkerSymbol() {
        let list = List {
            "Custom"
        }
        .listMarkerStyle(.custom("🔥"))

        let output = withTestRenderingEnvironment {
            list.markupString()
        }

        #expect(output.contains(#"--list-marker-content: '🔥'"#))
    }

    // MARK: - Row Background

    @Test("Row background registers context styles")
    func listRowBackgroundApplied() {
        withTestRenderingEnvironment {
            _ = List {
                Text("Row")
                    .listRowBackground(.red)
            }

            #expect(BuildContext.current.listRowContexts.count == 1)
        }
    }

    // MARK: - Row Padding

    @Test("Row padding sets edge-specific variables")
    func listRowPadding() {
        withTestRenderingEnvironment {
            _ = List {
                Text("Row")
                    .listRowInsets(.horizontal, 12)
            }

            #expect(BuildContext.current.listRowContexts.values.first?.styles.contains {
                $0.name == "--list-row-padding-left" && $0.value == "12px"
            } == true)
        }
    }

    // MARK: - Row Spacing

    @Test("Row spacing is registered")
    func listRowSpacing() {
        withTestRenderingEnvironment {
            _ = List {
                Text("Row")
                    .listRowSpacing(10)
            }

            guard let context = BuildContext.current.listRowContexts.values.first else {
                Issue.record("Expected list row context to exist")
                return
            }

            #expect(context.styles.contains {
                $0 == .variable("list-row-spacing", value: "10px")
            })
        }
    }

    // MARK: - Row Borders

    @Test("Row border applies per-edge variables")
    func listRowBorderEdges() {
        withTestRenderingEnvironment {
            let list = List {
                Text("Row")
                    .listRowBorder(.blue, width: 2, edges: [.top, .bottom])
            }

            let output = list.markupString()
            print(output)

            // Assert against the <li style="…">
            #expect(output.contains("--list-row-border-top"))
            #expect(output.contains("--list-row-border-bottom"))
            #expect(!output.contains("--list-row-border-left"))
        }
    }

    // MARK: - Corner Radius

    @Test("Row corner radius applies to all corners")
    func listRowCornerRadiusAll() {
        withTestRenderingEnvironment {
            let list = List {
                Text("Rounded")
                    .listRowCornerRadius(8)
            }

            let output = list.markupString()

            #expect(output.contains("--list-row-radius-top-leading"))
            #expect(output.contains("--list-row-radius-bottom-trailing"))
        }
    }

    @Test("Row corner radius on selected corners")
    func listRowCornerRadiusSelective() {
        withTestRenderingEnvironment {
            let list = List {
                Text("Selective")
                    .listRowCornerRadius([.topLeading, .bottomTrailing], 6)
            }

            let output = list.markupString()

            #expect(output.contains("--list-row-radius-top-leading: 6px"))
            #expect(output.contains("--list-row-radius-bottom-trailing: 6px"))
            #expect(!output.contains("--list-row-radius-top-trailing"))
        }
    }

    // MARK: - Mixed Content Safety

    @Test("Mixed inline and block content renders safely")
    func mixedContent() {
        let list = withTestRenderingEnvironment {
            List {
                Text("Inline")
                Section {
                    Text("Block")
                }
            }
        }

        let output = list.markupString()

        #expect(output.contains("Inline"))
        #expect(output.contains("Block"))
    }
}
