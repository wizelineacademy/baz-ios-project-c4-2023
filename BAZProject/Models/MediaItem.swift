//
//  MediaModel.swift
//  BAZProject
//
//  Created by gescarcega on 26/04/23.
//

import Foundation

struct MediaItem:  Hashable {
    
    var id: Int?
    var posterPath: String?
    var title: String?
    var rating: Float?
    var mediaType: MediaType?
    var releaseDate: Date?
    
}
