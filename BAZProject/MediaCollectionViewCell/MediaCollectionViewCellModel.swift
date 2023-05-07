//
//  MediaCollectionViewCellModel.swift
//  BAZProject
//
//  Created by gescarcega on 27/04/23.
//

import Foundation

struct MediaCollectionViewCellModel: Equatable {
    
    var title: String?
    var subtitle: String?
    var image: String?
    var rated: Bool = false
    var defaultImage: String?
    
    init(from item: MediaItem) {
        self.title = item.title
        self.image = item.posterPath
        self.defaultImage = item.mediaType?.defaultImage
        var subtitle: String?
        var rated = false
        if let releaseDate = item.releaseDate, releaseDate > Date() {
            subtitle =
            DateFormatter.getString(from: releaseDate)
        } else if let average = item.rating, average != 0 {
            subtitle = String(round(average * 10) / 10)
            rated = true
        }
        self.subtitle = subtitle
        self.rated = rated
    }
    
}
