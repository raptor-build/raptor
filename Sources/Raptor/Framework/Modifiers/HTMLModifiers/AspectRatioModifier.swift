//
// AspectRatio.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

typealias AspectRatioAmount = Amount<Double, AspectRatio>

/// A modifier that applies aspect ratio styling to HTML elements.
struct AspectRatioModifier: HTMLModifier {
    /// The aspect ratio to apply to the element.
    var ratio: AspectRatioAmount

    func body(content: Content) -> some HTML {
        var modified = content
        switch ratio {
        case .exact(let ratio):
            modified.attributes.append(styles: .aspectRatio(.ratio(ratio)))
        case .semantic(let ratio):
            modified.attributes.append(styles: .aspectRatio(.ratio(ratio.numericValue)))
        default: break
        }
        return modified
    }
}

public extension HTML {
    /// Applies a fixed aspect ratio to the current element.
    /// - Parameter ratio: The aspect ratio to apply.
    /// - Returns: A modified element with the aspect ratio applied.
    func aspectRatio(_ ratio: AspectRatio) -> some HTML {
        modifier(AspectRatioModifier(ratio: .semantic(ratio)))
    }

    /// Applies a custom ratio to the current element.
    /// - Parameter aspectRatio: The ratio to use, relative to 1.
    /// - Returns: A modified element with the aspect ratio applied.
    func aspectRatio(_ aspectRatio: Double) -> some HTML {
        modifier(AspectRatioModifier(ratio: .exact(aspectRatio)))
    }
}
