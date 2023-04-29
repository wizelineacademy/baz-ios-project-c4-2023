//
//  MediaType.swift
//  BAZProject
//
//  Created by gescarcega on 26/04/23.
//

import Foundation

public enum MediaType: String, Hashable {
    
    case tv, movie, person
    
    public var defaultImage: String {
        switch self {
        case .movie, .tv: return "poster"
        case .person: return "person.fill"
        }
    }
    
    public var groupTitle: String {
        switch self {
        case .movie: return "Movies"
        case .tv: return "TV Series"
        case .person: return "People"
        }
    }
    
    public var itemTitle: String {
        switch self {
        case .movie: return "Movie"
        case .tv: return "TV Series"
        case .person: return "Person"
        }
    }
    
}
