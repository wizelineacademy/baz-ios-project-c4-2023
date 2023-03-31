//
//  AlertSheetActions.swift
//  BAZProject
//
//  Created by 989438 on 31/03/23.
//

import Foundation

enum AlertSheetActions {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
    
    init?(rawValue: Int) {
        switch rawValue {
        case 0: self = .trending
        case 1: self = .nowPlaying
        case 2: self = .popular
        case 3: self = .topRated
        case 4: self = .upcoming
        default: return nil
        }
    }
}
