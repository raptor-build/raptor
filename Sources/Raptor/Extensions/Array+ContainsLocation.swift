//
// Array+ContainsLocation.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

extension Array where Element == Location {
    /// An extension that lets us determine whether one path is contained inside
    /// An array of `Location` objects.
    func contains(_ path: String) -> Bool {
        self.contains {
            $0.path == path
        }
    }
}
