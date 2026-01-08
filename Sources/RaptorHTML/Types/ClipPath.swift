//
// ClipPath.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

// swiftlint:disable identifier_name

/// Clips an element to a specific path, shape, or reference.
public enum ClipPath: Sendable {
    case none
    case inset(top: LengthUnit, right: LengthUnit, bottom: LengthUnit, left: LengthUnit, round: LengthUnit? = nil)
    case circle(radius: LengthUnit, at: (x: LengthUnit, y: LengthUnit)? = nil)
    case ellipse(rx: LengthUnit, ry: LengthUnit, at: (x: LengthUnit, y: LengthUnit)? = nil)
    case polygon(points: [(x: LengthUnit, y: LengthUnit)])
    case path(String)
    case url(String)
    case custom(String)

    var css: String {
        switch self {
        case .none:
            return "none"
        case .inset(let t, let r, let b, let l, let round):
            var base = "inset(\(t.css) \(r.css) \(b.css) \(l.css))"
            if let round { base += " round \(round.css)" }
            return base
        case .circle(let radius, let at):
            if let at { return "circle(\(radius.css) at \(at.x.css) \(at.y.css))" }
            return "circle(\(radius.css))"
        case .ellipse(let rx, let ry, let at):
            if let at { return "ellipse(\(rx.css) \(ry.css) at \(at.x.css) \(at.y.css))" }
            return "ellipse(\(rx.css) \(ry.css))"
        case .polygon(let points):
            let pairs = points.map { "\($0.x.css) \($0.y.css)" }.joined(separator: ", ")
            return "polygon(\(pairs))"
        case .path(let value):
            return "path('\(value)')"
        case .url(let value):
            return "url('\(value)')"
        case .custom(let raw):
            return raw
        }
    }
}

// swiftlint:enable identifier_name
