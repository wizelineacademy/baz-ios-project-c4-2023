//
//  Movie.swift
//  BAZProject
//
//

import Foundation

public struct Movie: CellPersonalizedTableViewProtocol, StorableObject {
    public let id: Int
    public let title: String
    let poster_path: String
    let overview: String
    let release_date: String?
    
    public init(id: Int, title: String, poster_path: String, overview: String, release_date: String) {
        self.id = id
        self.title = title
        self.poster_path = poster_path
        self.overview = overview
        self.release_date = release_date
    }
    
    public var strTitle: String {
        return title
    }
    public var strOverView: String? {
        return overview
    }
    public var urlConfiguration: URLConfiguration? {
        let urlConfiguration = URLConfiguration(strHost: "image.tmdb.org", path: .image(strFile: poster_path))
        return urlConfiguration
    }
    
    public var strDate: String? {
        return String.localizedStringWithFormat(NSLocalizedString("Release date: %@", comment: "Release date: %@"), release_date ?? "")
    }
}
