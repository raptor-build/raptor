//
// FontWeight.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// The list of standard font weights supported by HTML. This
/// is designed to match the same order provided by SwiftUI.
public extension Font {
    enum Weight: Int, CaseIterable, Sendable, CustomStringConvertible {
        case ultraLight = 100
        case thin = 200
        case light = 300
        case regular = 400
        case medium = 500
        case semibold = 600
        case bold = 700
        case heavy = 800
        case black = 900

        public var description: String {
            rawValue.formatted()
        }
    }
}

extension Font.Weight {
    /// Converts this `Raptor.Font.Weight` to a `RaptorHTML.FontWeight` representation.
    var html: RaptorHTML.FontWeight {
        switch self {
        case .ultraLight: .thin
        case .thin: .extraLight
        case .light: .light
        case .regular: .normal
        case .medium: .medium
        case .semibold: .semiBold
        case .bold: .bold
        case .heavy: .extraBold
        case .black: .black
        }
    }
}
