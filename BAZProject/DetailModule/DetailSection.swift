//
//  DetailSection.swift
//  BAZProject
//
//  Created by gescarcega on 06/05/23.
//

import Foundation

public enum DetailSection: Int, Hashable {
    
    case heading = 0
    case overview = 1
    case cast = 2
    case recommended = 3
    case similar = 4
    case filmography = 5
    
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
