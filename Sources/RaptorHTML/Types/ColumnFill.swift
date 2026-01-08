//
// ColumnFill.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how content is distributed between columns.
public enum ColumnFill: CustomStringConvertible, Sendable {
    case auto, balance, balanceAll

    public var description: String {
        switch self {
        case .auto: "auto"
        case .balance: "balance"
        case .balanceAll: "balance-all"
        }
    }
}
