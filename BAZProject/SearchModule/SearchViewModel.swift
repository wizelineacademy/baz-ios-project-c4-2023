//
//  SearchViewModel.swift
//  BAZProject
//
//  Created by gescarcega on 29/04/23.
//

import UIKit

class SearchViewModel {
    
    typealias MediaTableDataSource = UITableViewDiffableDataSource<MediaType, MediaItem>
    typealias MediaSnapshot = NSDiffableDataSourceSnapshot<MediaType, MediaItem>
    
    private var remoteData: SearchRemoteData
    private var localData: SearchLocalData
    private var snapshot = Box(MediaSnapshot())
    
    init(remoteData: SearchRemoteData, localData: SearchLocalData) {
        self.remoteData = remoteData
        self.localData = localData
    }
    
    func loadData() {
        let initialMedia = localData.getRecentlyViewedMovies().filter({ $0.mediaType != nil })
        let dctMedia = Dictionary(grouping: initialMedia, by: { $0.mediaType! })
        let sorted = dctMedia.sorted(by: { $0.key.order < $1.key.order })
        sorted.forEach { (key, value) in
            snapshot.value?.appendSections([key])
            snapshot.value?.appendItems(value)
        }
    }
    
    func bindSnapshot(_ bind: @escaping () -> Void) {
        snapshot.bind(bind)
    }
    
    func getSnapshot() -> MediaSnapshot? {
        return snapshot.value
    }
    
    func getCellModel(for item: MediaItem) -> MediaTableViewCellModel {
        switch item.mediaType {
        case .person:
            return MediaTableViewCellModel(title: item.title, subtitle: nil, image: item.posterPath, defaultImage: item.mediaType?.defaultImage, detail: nil, footNote: nil, rated: false)
        default:
            var footnote: String?
            var rated = false
            if let releaseDate = item.releaseDate, releaseDate > Date() {
                footnote = DateFormatter.common.string(from: releaseDate)
            } else if let average = item.rating, average != 0 {
                footnote = String(round(average * 10) / 10)
                rated = true
            }
            return MediaTableViewCellModel(title: item.title, subtitle: item.mediaType?.itemTitle, image: item.posterPath, defaultImage: item.mediaType?.defaultImage, detail: item.overview, footNote: footnote, rated: rated)
        }
    }
    
}
