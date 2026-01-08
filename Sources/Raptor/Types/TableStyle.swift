//
// TableStyle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Styling options for tables.
public enum TableStyle: Sendable {
    /// Corner styles applied to alternating table backgrounds.
    public enum TableRowCornerStyle: Sendable {
        case square
        case rounded(Int)
        public static var rounded: Self { .rounded(8) }
    }

    /// All table rows and columns look the same. The default.
    case plain

    /// Applies zebra striping to alternate rows.
    /// - Parameter corners: Corner rounding applied to the striped rows.
    case stripedRows(corners: TableRowCornerStyle)

    /// Applies zebra striping to alternate columns.
    /// - Parameter corners: Corner rounding applied to the striped columns.
    case stripedColumns(corners: TableRowCornerStyle)

    /// Applies zebra striping to alternate rows.
    public static var stripedRows: Self {
        .stripedRows(corners: .square)
    }

    /// Applies zebra striping to alternate columns.
    public static var stripedColumns: Self {
        .stripedColumns(corners: .square)
    }

    /// Uses the system’s best guess for table appearance.
    public static var automatic: Self { .plain }
}
