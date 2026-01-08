//
// PhasedElementConfiguration.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A container describing all inline styles associated with a button across its visual phases.
public typealias ButtonConfiguration = PhasedComponentConfiguration<ButtonPhase>

/// A container describing all inline styles associated with a disclosure across its visual phases.
public typealias DisclosureLabelConfiguration = PhasedComponentConfiguration<DisclosurePhase>

/// A container describing all inline styles associated with a component across its visual phases.
public struct PhasedComponentConfiguration<Phase: InteractionPhase>: Hashable, Stylable {
    /// The current phase of the component (e.g. `.initial`, `.hovered`, `.pressed`, `.disabled`).
    var phase: Phase

    /// The collection of inline styles grouped by phase.
    var styles = [Property]()

    /// The collection of identifiers of custom styles, grouped by phase.
    var styleClasses = [String]()

    init(phase: Phase) {
        self.phase = phase
    }

    init() {
        self.phase = Phase.allCases.first!
    }

    /// Indicates whether this configuration has any inline or attached styles.
    var isEmpty: Bool {
        styles.isEmpty && styleClasses.isEmpty
    }

    /// Returns a new configuration by adding a style to the current phase.
    public func style(_ style: Property) -> Self {
        var copy = self
        copy.styles.append(style)
        return copy
    }

    /// Returns a new configuration by registering and applying a reusable `Style` instance.
    public func style(_ style: some Style) -> Self {
        BuildContext.register(style)
        var copy = self
        copy.styleClasses.append(style.className)
        return copy
    }
}

public extension DisclosureLabelConfiguration {
    /// Sets the visual indicator symbol used in the disclosure label.
    /// - Parameter indicator: The disclosure indicator variant that determines
    ///   which symbol is rendered (e.g., `.chevron`, `.arrow`, or `.plusMinus`).
    /// - Returns: A modified ``DisclosureLabelConfiguration`` with the updated indicator style applied.
    func disclosureLabelIndicator(_ indicator: DisclosureIndicator) -> Self {
        self.style(.variable("disc-indicator", value: "'\(indicator.codepoint)'"))
    }
}
