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
    
    init(id: Int? = nil, original_title: String? = nil, overview: String? = nil, poster_path: String? = nil, release_date: String? = nil) {
        self.id = id
        self.original_title = original_title
        self.overview = overview
        self.poster_path = poster_path
        self.release_date = release_date
    }
    
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
