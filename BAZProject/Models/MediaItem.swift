//
//  MediaModel.swift
//  BAZProject
//
//  Created by gescarcega on 26/04/23.
//

import UIKit

public struct MediaItem: Hashable {
    
    public var id: Int?
    public var posterPath: String?
    public var title: String?
    public var rating: Float?
    public var mediaType: MediaType?
    public var releaseDate: Date?
    
}

public extension MediaItem {
    
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
