//
//  Models.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 29/03/23.
//

import Foundation

///Model that stores the response from TheMobieDB
class MovieApiResult: Decodable {
    var results: [Movie]?
}

///Model that stores a movie information, it comforms Viewable protocol so it can be shown in a Cell
class Movie: Decodable,Viewable {
    var id: Int?
    var original_title: String?
    var overview: String?
    var poster_path: String?
    var release_date: String?
    
    func getTitle() -> String {
        guard let title = original_title else { return "" }
        return title
    }
    
    func getImagePath() -> String {
        guard let path = poster_path else { return "" }
        return path
    }
}

protocol Viewable {
    func getTitle() -> String
    func getImagePath() -> String
}
