//
//  DetailSection.swift
//  BAZProject
//
//  Created by gescarcega on 06/05/23.
//

import Foundation

public enum DetailSection: Int, Hashable {
    
    case overview
    case cast
    case reviews
    case recommended
    case similar
    case filmography
    
    public var title: String? {
        switch self {
        case .cast: return "Top billed cast"
        case .recommended: return "Recommendations"
        case .similar: return "More like this"
        case .filmography: return "Filmography"
        case .reviews: return "Top Reviews"
        default: return nil
        }
    }
    
}
