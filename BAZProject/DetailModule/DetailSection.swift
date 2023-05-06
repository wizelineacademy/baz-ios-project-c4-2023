//
//  DetailSection.swift
//  BAZProject
//
//  Created by gescarcega on 06/05/23.
//

import Foundation

public enum DetailSection: SectionProtocol {
    
    case heading, overview, cast, recommended, similar, filmography
    
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
