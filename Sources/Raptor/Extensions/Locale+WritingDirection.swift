//
//  Locale+WritingDirection.swift
//  Raptor
//
//  Created by MohammavDev on 6/2/26.
//

import RaptorHTML
import Foundation


public extension Locale {
    
    /// writing direction for the current locale
    var writingDirection: WritingDirection {
        
        if self.language.characterDirection == .rightToLeft {
            return .rightToLeft
        }
        
        return .leftToRight
        
    }
    
    ///Indicate whether current locale is a Right To Left language or not?
    var isRTL : Bool {
        writingDirection == .rightToLeft
    }
}
