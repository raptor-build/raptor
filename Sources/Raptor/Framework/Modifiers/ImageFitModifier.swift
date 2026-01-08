//
// ImageFitModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension Image {
    /// Applies sizing and positioning behavior to an image.
    /// - Parameters:
    ///   - fit: The scaling behavior to apply to the image. Defaults to `.cover`
    ///   - anchor: The position within the container where the image should be anchored. Defaults to `.center`
    /// - Returns: A modified image with the specified fit and anchor point applied
    func imageFit(
        _ fit: ImageFit = .cover,
        anchor: UnitPoint = .center
    ) -> some InlineContent {
        let xPercent = Double(anchor.x * 100)
        let yPercent = Double(anchor.y * 100)
        var attributes = attributes
        attributes.append(classes: "w-100 h-100 object-fit-\(fit.rawValue)")
        attributes.append(styles: .objectPosition(.offset(x: .percent(xPercent), y: .percent(yPercent))))
        return self.attributes(attributes)
    }
}
