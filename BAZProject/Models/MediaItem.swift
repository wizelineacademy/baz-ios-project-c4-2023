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
    
    init(dataObject: MediaDataObject) {
        self.mediaType = MediaType(rawValue: dataObject.mediaType ?? "")
        self.rating = dataObject.voteAverage
        self.id = dataObject.id
        self.title = dataObject.title ?? dataObject.name
        self.posterPath = dataObject.posterPath ?? dataObject.profilePath
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.releaseDate = dateFormatter.date(from: dataObject.releaseDate ?? "")
    }
    
}
