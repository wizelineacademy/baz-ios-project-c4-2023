//
//  DetailViewModel.swift
//  BAZProject
//
//  Created by gescarcega on 05/05/23.
//

import UIKit

class DetailViewModel {
    
    private var remoteData: DetailRemoteData
    private var item: MediaItem
    
    init(remoteData: DetailRemoteData, item: MediaItem) {
        self.item = item
        self.remoteData = remoteData
    }
    
    func getDetailSections() -> [DetailSection]? {
        return item.mediaType?.section
    }
    
}

private extension MediaType {
    
    var section: [DetailSection] {
        switch self {
        case .tv: return [DetailSection.heading, DetailSection.overview, DetailSection.cast, DetailSection.recommended, DetailSection.similar]
        case .movie: return [DetailSection.heading, DetailSection.overview, DetailSection.cast, DetailSection.recommended, DetailSection.similar]
        case .person: return [DetailSection.heading, DetailSection.overview, DetailSection.filmography]
        }
    }
    
}
