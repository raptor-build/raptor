<p align="center">
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/user-attachments/assets/c7f37277-5a47-405b-b4f4-6be7b0625a61">
  <source media="(prefers-color-scheme: light)" srcset="https://github.com/user-attachments/assets/cd47c0ab-b675-42ad-a45f-309e730a3d17">
  <img alt="Shows a black logo in light color mode and a white one in dark color mode." src="https://user-images.githubusercontent.com/25423296/163456779-a8556205-d0a5-45e2-ac17-42d089e3c3f8.png" width="450">
</picture>
</p>

<h2 align="center">a Swift framework for static sites and server-side rendering</h2>

<p align="center">
   <img src="https://img.shields.io/badge/macOS-15.6+-2980b9.svg" />
   <img src="https://img.shields.io/badge/swift-6.2+-8e44ad.svg" />
   <img src="https://img.shields.io/badge/docs-raptor.build-e24b4a.svg" />
</p>

---

## What Is Raptor?

Raptor is a Swift static site generator that brings the SwiftUI developer experience to every nook and cranny of website creation—whether that's defining reusable components, building page layouts, or designing component-specific styles.

Raptor uses the latest Swift features and leverages advancements in vanilla HTML and CSS to generate modern, semantically correct websites. While its syntax mirrors SwiftUI, Raptor is not a SwiftUI-to-HTML converter. It's purpose-built for the web. As such, invalid layouts, missing content, and incompatible configurations are caught during compilation—not at runtime or in the browser.

To get started, visit: https://raptor.build/getting-started.

---

## Core Capabilities

- Websites authored **entirely in Swift**—no HTML, CSS, or JS required
- **Compiler-enforced type safety** that ensures valid, well-formed output
- Content publishing via Markdown posts with YAML front matter
- Syntax highlighting with numerous configurations
- Site-wide theming with light/dark support

---

## What Sets Raptor Apart

- Self-contained output with modern HTML and no reliance on external CSS frameworks
- **Multilingual support** with automatic routing and locale-aware content
- **Vapor integration** with server-side rendering, server actions, and property wrappers for server-side state
- Swift components embeddable directly in Markdown posts
- Built-in **site-wide search** powered by Lunr.js
- **Flexible concurrency model** that allows views to run on any single actor
- Dedicated style protocols for granular control of buttons, links, disclosures, and more
- Decoupled themes and color schemes for flexible visual control
- Scroll views with snap alignment, autoplay, and infinite marquee support
- SwiftUI-inspired presentation APIs for modals and popovers
- Hover effects, entry animations, and environment-driven effects
- Newsletter subscription forms with support for Mailchimp, SendFox, Kit, and Buttondown
- Cache-busting support to ensure stale assets can always be refreshed
- Automated font registration
- First-class documentation

For a full breakdown of features and APIs, see the documentation at: <br>
👉 **https://raptor.build**

---

## What Raptor Code Looks Like

Reusable components are defined like SwiftUI views:

```swift
struct FeaturedPost: HTML {
    var post: Post

    var body: some HTML {
        Text(post.title).font(.title2)
        Text(post.description)
        Link("Read More", destination: post)
            .linkStyle(.button)
    }
}
```

Components compose into complete pages:

```swift
struct MyPage: Page {
    var title = "My Site"
    @Environment(\.posts) private var posts

    var body: some HTML {
        Text("Welcome to My Site")
            .font(.title1)

        Text(markdown: "Built with **Raptor** and Swift.")

        Link("Get Started", destination: "/getting-started")
            .linkStyle(.button)

        Grid(posts) { post in
            FeaturedPost(post)
        }
    }
}
```

Layouts define structure independently of content:

```swift
struct MyLayout: Layout {
   var body: some Document {
       Navigation {
           InlineText("RAPTOR")
               .navigationItemRole(.logo)
       }

       Main()
           .margin(.bottom, 100)

       Footer {
           SubscribeForm()
       }
   }
}
```

Themes define dynamic site-wide styling:

```swift
struct MyTheme: Theme {
    func theme(site: Content, colorScheme: ColorScheme) -> Content {
        if colorScheme == .dark {
            site.accent(.red)
        } else {
            site.accent(.blue)
        }
    }
}
```

Best practices and detailed guides are available at: <br>
👉 https://raptor.build/getting-started

---

## Contributing

Contributions are welcome and appreciated. Small improvements (tests, documentation, comments, minor fixes) can be submitted directly. Larger changes (features, refactors, behavioral changes) should begin with an issue to discuss approach and scope. Please spend time using Raptor before attempting significant contributions—understanding its design goals will lead to better results for everyone.

---

## Project Status

Raptor is currently in public beta. While young, the framework already includes most features on our roadmap. As a result, sweeping architectural changes are unlikely, and future development will focus on incremental improvements that complement developments in HTML and CSS.

---

## Licensing

Raptor is licensed under MIT, which, with a little attribution, gives programmers nearly limitless freedom in using its code. This includes using Raptor code in closed-source projects, open-source projects with different licenses (unmodified Raptor code remains MIT; code unique to the project follows the project-specific license), and SSGs that better suit their own needs. Such use will never be challenged or criticized by the Raptor community—Raptor has a zero-tolerance policy for bullying, intimidation, or gatekeeping open-source code.

See the [LICENSE](LICENSE) file for full details.

---

## Acknowledgments

Raptor uses [Prism](https://github.com/prismjs/prism) for syntax highlighting, [Lunr.js](https://github.com/olivernn/lunr.js/) for search, [Bootstrap Icons](https://github.com/twbs/icons) for symbols, and builds upon its authors’ prior contributions to [Ignite](https://github.com/twostraws/ignite). These contributions include myriad modifiers, HTML elements, and bug fixes; features like site theming, environment-driven styling, and animations; and the very APIs responsible for its SwiftUI-like syntax—`@Environment` and the `HTML` protocol. That is, hundreds of hours of work that shaped Ignite’s current API and served as the launchpad for Raptor’s own.

Consequently, Raptor employs a handful of Ignite’s models, type extensions, and tests without modification. They create a small foundation that supports Raptor’s distinct architecture: parameter packs and variadic generics, a rendering pipeline that integrates with Vapor and supports multiple languages, bespoke HTML/CSS/JS output devoid of Bootstrap, a concurrency model that uses task-local values, and Markdown-embeddable Swift views. An exhaustive list can be found in the documentation.

All of the above projects are MIT licensed. Their licenses can be found in the `LICENSES` folder.

---

## Development Notes

Early in development, we used Cursor to explore pair-programming with AI. However, as the framework’s reliance on advanced Swift features grew, the returns diminished. Ultimately, AI usage revolved around HTML/CSS/JS generation, drafting documentation, and assisting with select implementations. No part of the framework was vibe-coded or written by agents.

Where AI fell short, these two articles bridged the gap: [SwiftUI under the Hood: Variadic Views](https://movingparts.io/variadic-views-in-swiftui) and [How to use VariadicView, SwiftUI's Private View API](https://www.emergetools.com/blog/posts/how-to-use-variadic-view). While we felt the commit log of Raptor’s development branch was too messy to showcase, we hope to share development insights through similar deep dives.
