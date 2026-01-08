//
// BackgroundPosition.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Represents the `background-position` CSS property, controlling how a background image is placed within an element.
public struct BackgroundPosition: Sendable {
    /// A numeric position value expressed as pixels or percentage.
    public enum Value: Sendable {
        /// Absolute pixel offset (e.g. `10px`)
        case fixed(Double)

        /// Percentage offset (e.g. `50%`)
        case scaled(Int)

        public static var zero: Self { .scaled(0) }

        var style: Property {
            switch self {
            case .fixed(let value): .backgroundPosition(.offset(x: .px(value), y: nil))
            case .scaled(let value): .backgroundPosition(.offset(x: .percent(Double(value)), y: nil))
            }
        }

        var css: String {
            style.value
        }
    }

    /// Horizontal alignment keyword or absolute value.
    public enum HorizontalAlignment: Sendable {
        case leading
        case center
        case trailing
        case absolute(Value)

        var css: String {
            switch self {
            case .leading: "left"
            case .center: "center"
            case .trailing: "right"
            case .absolute(let value): value.style.value
            }
        }

        static func value(for alignment: Self) -> Value {
            switch alignment {
            case .leading: .scaled(0)
            case .center: .scaled(50)
            case .trailing: .scaled(100)
            case .absolute(let value): value
            }
        }
    }

    /// Vertical alignment keyword or absolute value.
    public enum VerticalAlignment: Sendable {
        case top
        case center
        case bottom
        case absolute(Value)

        var css: String {
            switch self {
            case .top: "top"
            case .center: "center"
            case .bottom: "bottom"
            case .absolute(let value): value.style.value
            }
        }

        static func value(for alignment: Self) -> Value {
            switch alignment {
            case .top: .scaled(0)
            case .center: .scaled(50)
            case .bottom: .scaled(100)
            case .absolute(let value): value
            }
        }
    }

    public static var center: Self { .init() }
    public static var top: Self { .init(vertical: .top) }
    public static var bottom: Self { .init(vertical: .bottom) }
    public static var leading: Self { .init(horizontal: .leading) }
    public static var trailing: Self { .init(horizontal: .trailing) }
    public static var topLeading: Self { .init(vertical: .top, horizontal: .leading) }
    public static var topTrailing: Self { .init(vertical: .top, horizontal: .trailing) }
    public static var bottomTrailing: Self { .init(vertical: .bottom, horizontal: .leading) }
    public static var bottomLeading: Self { .init(vertical: .bottom, horizontal: .trailing) }

    var css: String {
        [horizontalPosition, verticalPosition].joined(separator: " ")
    }

    /// Creates a position relative to horizontal and vertical alignments with offsets.
    /// - Parameters:
    ///   - vertical: The vertical offset amount.
    ///   - relativeToVertical: The vertical alignment to offset from.
    ///   - horizontal: The horizontal offset amount.
    ///   - relativeToHorizontal: The horizontal alignment to offset from.
    public static func position(
        vertical: Value,
        relativeTo relativeToVertical: VerticalAlignment,
        horizontal: Value,
        relativeTo relativeToHorizontal: HorizontalAlignment
    ) -> Self {
        .init(
            verticalPosition: "calc(\(VerticalAlignment.value(for: relativeToVertical).css) + \(vertical.css))",
            horizontalPosition: "calc(\(HorizontalAlignment.value(for: relativeToHorizontal).css) + \(horizontal.css))"
        )
    }

    private let verticalPosition: String
    private let horizontalPosition: String

    public init(vertical: VerticalAlignment = .center, horizontal: HorizontalAlignment = .center) {
        self.verticalPosition = vertical.css
        self.horizontalPosition = horizontal.css
    }

    private init(verticalPosition: String, horizontalPosition: String) {
        self.verticalPosition = verticalPosition
        self.horizontalPosition = horizontalPosition
    }
}
