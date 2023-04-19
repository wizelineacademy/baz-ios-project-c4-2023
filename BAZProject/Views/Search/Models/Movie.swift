//
//  Movie.swift
//  BAZProject
//
//

import Foundation

public struct Movie: ImageTextTableViewProtocol {
    let id: Int
    public let title: String
    let poster_path: String
    let overview: String
    
    public init(id: Int, title: String, poster_path: String, overview: String) {
        self.id = id
        self.title = title
        self.poster_path = poster_path
        self.overview = overview
    }
    
    public var strTitle: String{
        return title
    }
    public var strOverView: String{
        return overview
    }
    public var urlConfiguration: URLConfiguration {
        let urlConfiguration = URLConfiguration(strHost: "image.tmdb.org", path: .image(strFile: poster_path))
        return urlConfiguration
    }
}
