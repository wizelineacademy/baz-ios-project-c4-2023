//
//  MediaDataObject.swift
//  BAZProject
//
//  Created by gescarcega on 29/03/23.
//

import Foundation

struct MediaDataObject: Decodable, Equatable, Hashable {
    
    var id: Int?
    var title: String?
    var posterPath: String?
    var mediaType: String?
    var voteAverage: Float?
    var name: String?
    var releaseDate: String?
    var profilePath: String?
    var firstAirDate: String?
    
}
