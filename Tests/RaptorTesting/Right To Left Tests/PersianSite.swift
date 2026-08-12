//
//  PersianSite.swift
//  Raptor
//
//  Created by MohammavDev on 6/2/26.
//

import Raptor


//Example PersianSite for tests

struct MainLayout: Layout {
    var body: some Document {
        Navigation {
            InlineText("My Site")
                .navigationItemRole(.logo)
            
            InlineText("Home page")
        }
        Main {
            content
            RaptorFooter()
        }
    }
}


struct Home: Page {
    var title = "Home"

    var body: some HTML {
        HStack{
            Text("First one!")
                .font(.title1)
            Text("Second one!")
                .font(.title1)

        }
    }
}

///Example PersianSite for tests
struct PersianSite : Site {
    
    
    
    
    /// An example site used in tests.

    var name = "My Test Persian site"
    var titleSuffix = " - My Test Subsite"
    var url = URL(static: "https://www.persian.com/subsite")

    var homePage = Home()
    var layout = MainLayout()
    var locales: [Locale] = [.persian]
    
}
