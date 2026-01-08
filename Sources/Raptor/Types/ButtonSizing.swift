//
// ButtonSizing.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how the button should size itself
public enum ButtonSizing: CaseIterable {
    /// Button sizes to fit its content exactly
    case fitted
    /// Button takes up all available horizontal space
    case flexible

    /// Default automatic sizing based on content and context
    public static var automatic: Self {
        .fitted
    }

    var cssClass: String? {
        switch self {
        case .fitted: nil
        case .flexible: "btn-flexible"
        }
    }
}
