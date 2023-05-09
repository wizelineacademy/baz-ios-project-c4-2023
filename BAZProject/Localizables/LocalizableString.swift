//
//  HomeString.swift
//  BAZProject
//
//  Created by jehernandezg on 24/04/23.
//

import Foundation


///Enum for use localizableString in the app
enum LocalizableString: String {
    case labelTitle
    case searchTitle
    case searchPlaceholder
    case originalTitle
    case releaseDate
    case overview
    case originalLanguaje
    case popularity
    case voteAverage
    case voteCount
    case recomendationTitle
    case similarTitle
    
    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "Localizable")
    }
}
