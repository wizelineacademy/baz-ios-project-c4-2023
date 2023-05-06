//
//  DetailViewModel.swift
//  BAZProject
//
//  Created by gescarcega on 05/05/23.
//

import UIKit

class DetailViewModel {
    
    typealias DetailSnapshot = NSDiffableDataSourceSnapshot<DetailSection, AnyHashable>
    
    private var remoteData: DetailRemoteData
    private var item: MediaItem
    var snapshot = Box(DetailSnapshot())
    
    init(remoteData: DetailRemoteData, item: MediaItem) {
        self.item = item
        self.remoteData = remoteData
    }
    
    func bindSnapshot(_ listener: @escaping (DetailSnapshot) -> Void) {
        snapshot.bind(listener)
    }
    
    func getDetailSections() -> [DetailSection]? {
        return item.mediaType?.sections
    }
    
}

private extension MediaType {
    
    var sections: [DetailSection] {
        switch self {
        case .tv: return [DetailSection.heading, DetailSection.overview, DetailSection.cast, DetailSection.recommended, DetailSection.similar]
        case .movie: return [DetailSection.heading, DetailSection.overview, DetailSection.cast, DetailSection.recommended, DetailSection.similar]
        case .person: return [DetailSection.heading, DetailSection.overview, DetailSection.filmography]
        }
    }
    
}
