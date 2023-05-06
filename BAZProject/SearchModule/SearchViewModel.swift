//
//  SearchViewModel.swift
//  BAZProject
//
//  Created by gescarcega on 29/04/23.
//

import UIKit

class SearchViewModel {
    
    typealias MediaTableDataSource = UITableViewDiffableDataSource<Int, MediaItem>
    typealias MediaSnapshot = NSDiffableDataSourceSnapshot<Int, MediaItem>
    
    private var remoteData: SearchRemoteData
    private var localData: SearchLocalData
    private var mediaSnapshot = Box(MediaSnapshot())
    private var error: Box<Error?> = Box(nil)
    
    init(remoteData: SearchRemoteData, localData: SearchLocalData) {
        self.remoteData = remoteData
        self.localData = localData
    }
    
    func loadData() {
        guard let initialMedia = localData.getRecentlySearchedMedia()?.filter({ $0.mediaType != nil }) else { return }
        var snapshot = MediaSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(initialMedia)
        mediaSnapshot.value = snapshot
    }
    
    func bindSnapshot(_ bind: @escaping (MediaSnapshot) -> Void) {
        mediaSnapshot.bind(bind)
    }
    
    func bindError(_ bind: @escaping (Error?) -> Void) {
        error.bind(bind)
    }
    
    func getCellModel(for item: MediaItem) -> MediaTableViewCellModel {
        switch item.mediaType {
        case .person:
            return MediaTableViewCellModel(title: item.title, subtitle: nil, image: item.posterPath, defaultImage: item.mediaType?.defaultImage, footNote: nil, rated: false)
        default:
            var footnote: String?
            var rated = false
            if let releaseDate = item.releaseDate, releaseDate > Date() {
                footnote =
                DateFormatter.getString(from: releaseDate)
            } else if let average = item.rating, average != 0 {
                footnote = String(round(average * 10) / 10)
                rated = true
            }
            return MediaTableViewCellModel(title: item.title, subtitle: item.mediaType?.itemTitle, image: item.posterPath, defaultImage: item.mediaType?.defaultImage, footNote: footnote, rated: rated)
        }
    }
    
    func getSectionTitle(for section: Int) -> String? {
        return section == 0 ? "Recent" : "Results"
    }
    
    func searchMedia(keyword: String) {
        Task {
            do {
                guard let mediaObjects = try await remoteData.searchMedia(keyword) else { return }
                let mediaItems = formatMediaDataObject(mediaObjects)
                var snapshot = MediaSnapshot()
                snapshot.appendSections([0])
                snapshot.appendItems(mediaItems)
                mediaSnapshot.value = snapshot
            } catch {
                self.error.value = error
            }
        }
    }
    
    func formatMediaDataObject(_ dataObject: [MediaDataObject]) -> [MediaItem] {
        return dataObject.map({ MediaItem(dataObject: $0) }).filter({ $0.mediaType != nil })
    }
    
}
