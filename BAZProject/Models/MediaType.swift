//
//  MediaType.swift
//  BAZProject
//
//  Created by gescarcega on 26/04/23.
//

import Foundation

enum MediaType: String {
    
    case tv, movie, person
    
    var defaultImage: String {
        switch self {
        case .movie, .tv: return "poster"
        case .person: return "person.fill"
        }
    }
    
    var groupTitle: String {
        switch self {
        case .movie: return "Movies"
        case .tv: return "TV Series"
        case .person: return "People"
        }
    }
    
    var itemTitle: String {
        switch self {
        case .movie: return "Movie"
        case .tv: return "TV Series"
        case .person: return "Person"
        }
    }
    
}

extension RawRepresentable {
    
    init?(_ optionalRawValue: RawValue?) {
        guard let optionalRawValue = optionalRawValue else { return nil }
        self.init(rawValue: optionalRawValue)
    }
    
}
