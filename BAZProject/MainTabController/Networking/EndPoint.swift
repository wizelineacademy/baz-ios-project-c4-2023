//
//  EndPoint.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import Foundation

enum Endpoint {
    static var baseURL = "https://api.themoviedb.org/3/"
    
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
}
