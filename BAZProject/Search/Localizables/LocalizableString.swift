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
    
    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "Localizable")
    }
}
