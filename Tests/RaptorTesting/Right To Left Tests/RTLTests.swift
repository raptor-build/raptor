//
//  RTLTests.swift
//  Raptor
//
//  Created by MohammavDev on 6/3/26.
//

import Foundation
import Testing

@testable import Raptor
import RaptorHTML





@Suite("Tests related to RTL support")
struct RTLTests {
    
    @Test("Test for rendering context in RTL languages")
    func renderingContextTests() throws {
        
        let site = PersianSite()
        let siteContext = PersianSite().context
        var context = RenderingContext(site: siteContext, posts: [], rootDirectory: .fake(), buildDirectory: .fake())
        
        context.environment = .init(rootDirectory:.fake() , site: siteContext, locale: .persian , allContent: [])
        
        let rendered = context.render(site.homePage, using: site.layout)
        
        let html = rendered.html
        
        let htmlTag = "<html lang=\"fa\" style=\"direction: rtl\""
        #expect(html.contains(htmlTag))
    }
    
    @Test("EnvironmentValues writingDirection tests")
    func environmentValuesTests() {
        var env = EnvironmentValues()
        env.locale = .persian
        
        #expect(env.writingDirection == .rightToLeft)
        
    }
    
    @Test("Writing direction tests")
    func writingDirectionTests() throws {
        let ltrs  : [Locale] = [.english,.french,.spanish]
        
        var directions = ltrs.map(\.writingDirection)
        
        #expect(directions.allSatisfy({ dir in
            dir == .leftToRight
        }))
        
        let rtl: [Locale] = [.persian,.arabic,.hebrew,.urdu,.pashto]
        directions = rtl.map(\.writingDirection)
        
        #expect(directions.allSatisfy{ dir in
            dir == .rightToLeft
        })
    }
}
