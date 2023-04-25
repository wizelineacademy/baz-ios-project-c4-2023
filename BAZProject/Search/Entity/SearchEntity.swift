//
//  SearchEntity.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//  
//

import Foundation

struct SearchEntity {
    
    var strNavBarTitle : String = "" //TODO: Set the nav bar title
    var result: [Movie]?
    
    
}

struct SearchMovieResult: Decodable{
    let results:  [Movie]
}
