//
// Never+HTML.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

extension Never: HTML, InlineContent {
    public var body: Never {
        return fatalError("Never has no body.")
    }

    public var stableID: String? { nil }

    public var attributes: CoreAttributes {
        get { CoreAttributes() }
        set {} // swiftlint:disable:this unused_setter_value
    }

    public func render() -> Markup {
        fatalError("Never cannot produce markup.")
    }
}

extension Never: @retroactive CustomStringConvertible {}
