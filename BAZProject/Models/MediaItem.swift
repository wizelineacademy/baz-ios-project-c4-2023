//
//  MediaModel.swift
//  BAZProject
//
//  Created by gescarcega on 26/04/23.
//

import Foundation

struct MediaItem: Hashable {
    
    var id: Int?
    var posterPath: String?
    var title: String?
    var rating: Float?
    var mediaType: MediaType?
    var releaseDate: Date?
    
}

extension MediaItem {
    
    init(dataObject: MediaDataObject, mediaType: MediaType? = nil) {
        self.mediaType = MediaType(rawValue: dataObject.mediaType ?? "") ?? mediaType
        self.rating = dataObject.voteAverage
        self.id = dataObject.id
        self.title = dataObject.title ?? dataObject.name
        self.posterPath = dataObject.posterPath ?? dataObject.profilePath
        self.releaseDate = DateFormatter.getDate(from: dataObject.releaseDate ?? dataObject.firstAirDate)
    }
    
}
