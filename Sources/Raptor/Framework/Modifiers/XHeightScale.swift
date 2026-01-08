//
// XHeightScale.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    func xHeightScale(_ scale: Double) -> some HTML {
        self.style(.fontSizeAdjust(scale))
    }
}

public extension InlineContent {
    func xHeightScale(_ scale: Double) -> some InlineContent {
        self.style(.fontSizeAdjust(scale))
    }
}
