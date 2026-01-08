//
// EnvironmentConditions.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A type that represents a combination of environment conditions for styling content.
public struct EnvironmentConditions: Equatable, Hashable, Sendable {
    /// The user's preferred color scheme.
    public var colorScheme: SystemColorScheme?

    /// Whether the user prefers reduced motion.
    public var isMotionReduced: Bool {
        motion == .decreased
    }

    /// The user's preferred motion settings.
    var motion: MotionProminence?

    /// The user's preferred contrast settings.
    public var contrastLevel: ContrastLevel?

    /// The user's preferred transparency settings.
    public var transparencyLevel: TransparencyLevel?

    /// The browser's current orientation.
    public var layoutOrientation: Orientation?

    /// The web application's display mode.
    public var displayMode: DisplayMode?

    /// The current breakpoint query.
    public var horizontalSizeClass: HorizontalSizeClass = .none

    /// The current theme identifier.
    public var theme: (any Theme.Type)?

    /// Creates a new environment conditions instance.
    /// - Parameters:
    ///   - colorScheme: The preferred color scheme
    ///   - motion: The preferred motion settings
    ///   - contrast: The preferred contrast settings
    ///   - transparency: The preferred transparency settings
    ///   - orientation: The device orientation
    ///   - displayMode: The display mode
    ///   - breakpoint: The breakpoint query
    ///   - theme: The theme identifier
    init(
        colorScheme: SystemColorScheme? = nil,
        motion: MotionProminence? = nil,
        contrast: ContrastLevel? = nil,
        transparency: TransparencyLevel? = nil,
        orientation: Orientation? = nil,
        displayMode: DisplayMode? = nil,
        breakpoint: HorizontalSizeClass = .none,
        theme: (any Theme.Type)? = nil
    ) {
        self.colorScheme = colorScheme
        self.motion = motion
        self.contrastLevel = contrast
        self.transparencyLevel = transparency
        self.layoutOrientation = orientation
        self.displayMode = displayMode
        self.horizontalSizeClass = breakpoint
        self.theme = theme
    }

    /// Returns an array of EnvironmentConditions where each instance
    /// has exactly one property set (decomposed from the current state).
    func decomposed() -> [EnvironmentConditions] {
        var result: [EnvironmentConditions] = []

        if let colorScheme { result.append(.init(colorScheme: colorScheme)) }
        if let motion { result.append(.init(motion: motion)) }
        if let contrastLevel { result.append(.init(contrast: contrastLevel)) }
        if let transparencyLevel { result.append(.init(transparency: transparencyLevel)) }
        if let layoutOrientation { result.append(.init(orientation: layoutOrientation)) }
        if let displayMode { result.append(.init(displayMode: displayMode)) }
        if horizontalSizeClass != .none { result.append(.init(breakpoint: horizontalSizeClass)) }
        if let theme { result.append(.init(theme: theme)) }

        return result
    }

    var count: Int {
        var count = 0
        if colorScheme != nil { count += 1 }
        if layoutOrientation != nil { count += 1 }
        if transparencyLevel != nil { count += 1 }
        if displayMode != nil { count += 1 }
        if motion != nil { count += 1 }
        if contrastLevel != nil { count += 1 }
        if horizontalSizeClass != .none { count += 1 }
        if theme != nil { count += 1 }
        return count
    }

    public static func == (lhs: EnvironmentConditions, rhs: EnvironmentConditions) -> Bool {
        lhs.colorScheme == rhs.colorScheme &&
        lhs.motion == rhs.motion &&
        lhs.contrastLevel == rhs.contrastLevel &&
        lhs.transparencyLevel == rhs.transparencyLevel &&
        lhs.layoutOrientation == rhs.layoutOrientation &&
        lhs.displayMode == rhs.displayMode &&
        lhs.horizontalSizeClass == rhs.horizontalSizeClass &&
        lhs.theme == rhs.theme
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(colorScheme)
        hasher.combine(motion)
        hasher.combine(contrastLevel)
        hasher.combine(transparencyLevel)
        hasher.combine(layoutOrientation)
        hasher.combine(displayMode)
        hasher.combine(horizontalSizeClass)
        if let theme = theme {
            hasher.combine(theme.cssID)
        }
    }
}
