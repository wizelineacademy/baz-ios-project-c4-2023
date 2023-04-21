//
//  TrendingEntity.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//  
//

import Foundation
import UIKit

struct TrendingEntity {
    
    var strNavBarTitle : String = "" //TODO: Set the nav bar title
    var result         : [Movie]?
    
}

struct Movie: Decodable, Equatable {
    let id: Int
    let title: String
    let poster_path: String
    let image: Data?
}

struct TrendingMovieResult: Decodable{
    let results:  [Movie]
}
