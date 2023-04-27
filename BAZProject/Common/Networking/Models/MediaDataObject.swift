//
//  MediaDataObject.swift
//  BAZProject
//
//  Created by gescarcega on 29/03/23.
//

import Foundation

struct MediaDataObject: Decodable, Equatable {
    
    var id: Int?
    var title: String?
    var posterPath: String?
    var mediaType: String?
    var voteAverage: Float?
    
}
