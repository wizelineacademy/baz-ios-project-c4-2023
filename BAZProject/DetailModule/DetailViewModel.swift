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
    
    func getDetailSections() -> [DetailSections]? {
        return item.mediaType?.section
    }
    
}

enum DetailSections: SectionProtocol {
    
    case heading, overview, cast, recommended, similar, filmography
    
    var title: String? {
        switch self {
        case .cast: return "Top billed cast"
        case .recommended: return "Recommendations"
        case .similar: return "More like this"
        case .filmography: return "Filmography"
        default: return nil
        }
    }
    
}

private extension MediaType {
    
    var section: [DetailSections] {
        switch self {
        case .tv: return [DetailSections.heading, DetailSections.overview, DetailSections.cast, DetailSections.recommended, DetailSections.similar]
        case .movie: return [DetailSections.heading, DetailSections.overview, DetailSections.cast, DetailSections.recommended, DetailSections.similar]
        case .person: return [DetailSections.heading, DetailSections.overview, DetailSections.filmography]
        }
    }
    
}
