//
//  DetailsSubSections.swift
//  BAZProject
//
//  Created by Carlos Garcia on 30/04/23.
//

import Foundation

enum DetailsSubSections: Int, CaseIterable {
    case review
    case similar
    case recommendations
    
    var title: String {
        switch self {
        case .review:
            return "Reseña"
        case .similar:
            return "Títulos similares"
        case .recommendations:
            return "Recomendaciones"
        }
    }
}
