//
// BackgroundAttachment.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines whether a background image scrolls with the page or remains fixed.
public enum BackgroundAttachment: String, Sendable {
    case scroll
    case fixed
    case local

    var css: String { rawValue }
}
