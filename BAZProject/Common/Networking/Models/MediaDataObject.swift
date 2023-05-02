//
//  MediaDataObject.swift
//  BAZProject
//
//  Created by gescarcega on 29/03/23.
//

import Foundation

public struct MediaDataObject: Decodable, Equatable {
    
    public var id: Int?
    public var title: String?
    public var posterPath: String?
    public var mediaType: String?
    public var voteAverage: Float?
    public var name: String?
    public var releaseDate: String?
    public var profilePath: String?
    public var overview: String?
    
}
