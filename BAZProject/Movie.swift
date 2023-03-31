//
//  Movie.swift
//  BAZProject
//
//

import Foundation

protocol ListMovieProtocol {
    var id: Int { get set }
    var title: String { get set }
    var poster_path: String { get set }
}

struct Movie: ListMovieProtocol{
    var id: Int
    var title: String
    var poster_path: String
}
