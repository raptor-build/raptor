//
// GrayscaleModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Applies a grayscale effect to this view.
    /// - Parameter amount: A value from `0.0` (no grayscale) to `1.0`
    ///   (fully grayscale).
    func grayscale(_ amount: Double = 1) -> some HTML {
        self.style(.filter(.grayscale(amount)))
    }
}

public extension InlineContent {
    /// Applies a grayscale effect to this view.
    /// - Parameter amount: A value from `0.0` (no grayscale) to `1.0`
    ///   (fully grayscale).
    func grayscale(_ amount: Double = 1) -> some InlineContent {
        self.style(.filter(.grayscale(amount)))
    }
}
