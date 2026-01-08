//
// URL+PackageDirectory.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

public extension URL {
    /// Returns URL where to find Assets/Content/Includes and URL where to generate the static web site.
    /// - Parameter file: path of a Swift source file to find source root directory by scanning path upwards.
    /// - Returns tuple containing source URL and URL where output is built.
    static func packageDirectory(from file: StaticString) throws -> URL {
        var currentURL = URL(filePath: file.description)

        while currentURL.path != "/" {
            currentURL = currentURL.deletingLastPathComponent()
            let packageURL = currentURL.appending(path: "Package.swift")

            if FileManager.default.fileExists(atPath: packageURL.path) {
                return packageURL.deletingLastPathComponent()
            }
        }

        throw BuildError.missingPackageDirectory
    }
}
