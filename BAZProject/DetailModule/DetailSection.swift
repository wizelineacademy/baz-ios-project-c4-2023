//
//  DetailSection.swift
//  BAZProject
//
//  Created by gescarcega on 06/05/23.
//

import Foundation

public enum DetailSection: Int, Hashable {
    
    case overview = 0
    case cast = 1
    case recommended = 2
    case similar = 3
    case filmography = 4
    
    public var title: String? {
        switch self {
        case .cast: return "Top billed cast"
        case .recommended: return "Recommendations"
        case .similar: return "More like this"
        case .filmography: return "Filmography"
        default: return nil
        }
    }
    
}
