//
//  Section.swift
//  BAZProject
//
//  Created by Carlos Garcia on 19/04/23.
//

import Foundation

struct Section: MovieSection {
    var strTitle: String
    var movies: [MovieInfo]
    
    init(title: String, movies: [MovieInfo] = []) {
        self.strTitle = title
        self.movies = movies
    }
}
