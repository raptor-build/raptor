//
//  URL+fake.swift
//  Raptor
//
//  Created by MohammavDev on 6/3/26.
//

import Foundation


extension URL {
    static func fake(path: String = "") -> URL {
        return URL(fileURLWithPath: "\(path)")
    }
}
