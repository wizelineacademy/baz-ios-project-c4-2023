//
//  Movie.swift
//  BAZProject
//
//

import Foundation


protocol ListMoviesProtocol { 
    var id: Int { get set }
    var title: String { get set }
    var poster_path: String { get set }
}

struct Movie: ListMoviesProtocol {
    var id: Int
    var title: String
    var poster_path: String
}
