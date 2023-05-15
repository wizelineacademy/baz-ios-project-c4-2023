//
//  MoviesViewModels.swift
//  BAZProject
//
//  Created by nmorenoa on 30/03/23.
//

import Foundation
import UIKit

struct MoviesViewModels: MovieData{
    var title               : String
    var poster_path         : String?
    var original_title      : String
    var id                  : Int
    var overview            : String
}

protocol MovieData {
    var title           : String { get }
    var poster_path     : String? { get }
    var original_title  : String { get }
    var id              : Int    { get }
    var overview        : String { get }
}

struct ReviewsInformation   : ReviewsMovieData{
    var author              : String
    var avatar_path         : String?
    var content             : String
}

protocol ReviewsMovieData {
    
    var author          : String { get }
    var avatar_path     : String? { get }
    var content         : String { get }
    
}

struct InfoDetailModel: InfoDetailData {
    
    var title       : String
    var posterPath  : String?
    var overview    : String
}

protocol InfoDetailData {
    
    var title           : String { get }
    var posterPath      : String? { get }
    var overview        : String { get }
    
}
