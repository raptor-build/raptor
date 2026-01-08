//
// Raptor.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

@_exported import RaptorHTML
@_exported import Foundation
@_exported import OrderedCollections
@_exported import struct OrderedCollections.OrderedSet

/// The location the the Raptor bundle. Used to access resources.
public var bundle: Bundle { Bundle.module }

/// The current version. Used to write generator information.
public let version = "Raptor v0.1.0"
