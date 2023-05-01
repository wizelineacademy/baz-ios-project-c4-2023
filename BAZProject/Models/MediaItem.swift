//
//  MediaModel.swift
//  BAZProject
//
//  Created by gescarcega on 26/04/23.
//

import UIKit

struct MediaItem: Hashable {
    
    var id: Int?
    var posterPath: String?
    var title: String?
    var rating: Float?
    var mediaType: MediaType?
    var releaseDate: Date?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(mediaType)
        hasher.combine(releaseDate)
    }

    static func == (lhs: MediaItem, rhs: MediaItem) -> Bool {
        return lhs.id == rhs.id && lhs.mediaType == rhs.mediaType && lhs.releaseDate == rhs.releaseDate
    }
    
}
