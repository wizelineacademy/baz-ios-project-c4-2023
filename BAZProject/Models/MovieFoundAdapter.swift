//
//  MovieFoundAdapter.swift
//  BAZProject
//
//  Created by Carlos Garcia on 28/04/23.
//

import Foundation

struct MovieFoundAdapter: MovieInfo {
    var id: Int {
        get {
            movieFound.id
        }
    }
    
    var title: String {
        get {
            movieFound.title
        }
    }
    
    var posterPath: String? {
        get {
            movieFound.posterPath
        }
    }
    
    private let movieFound: MovieFoundInfo
    
    init(_ movieFound: MovieFoundInfo) {
        self.movieFound = movieFound
    }
}
