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
    
    var strTitle: String{
        return title
    }
    var strOverView: String{
        return overview
    }
    var urlConfiguration: URLConfiguration{
        let urlConfiguration = URLConfiguration(strHost: "image.tmdb.org", path: .image(strFile: poster_path))
        return urlConfiguration
    }
}
