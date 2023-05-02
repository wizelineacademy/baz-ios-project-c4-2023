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
    private var snapshot = Box(MediaSnapshot())
    private var error: Box<Error?> = Box(nil)
    
    init(remoteData: SearchRemoteData, localData: SearchLocalData) {
        self.remoteData = remoteData
        self.localData = localData
    }
    
    func loadData() {
        let initialMedia = localData.getRecentlySearchedMovies().filter({ $0.mediaType != nil })
        resetSnapshot(with: initialMedia, in: 0)
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
            return MediaTableViewCellModel(title: item.title, subtitle: nil, image: item.posterPath, defaultImage: item.mediaType?.defaultImage, footNote: nil, rated: false)
        default:
            var footnote: String?
            var rated = false
            if let releaseDate = item.releaseDate, releaseDate > Date() {
                footnote = DateFormatter.common.string(from: releaseDate)
            } else if let average = item.rating, average != 0 {
                footnote = String(round(average * 10) / 10)
                rated = true
            }
            return MediaTableViewCellModel(title: item.title, subtitle: item.mediaType?.itemTitle, image: item.posterPath, defaultImage: item.mediaType?.defaultImage, footNote: footnote, rated: rated)
        }
    }
    
    func getSectionTitle(for: Int) -> String? {
        return snapshot.value.sectionIdentifiers.contains(0) ? "Recent" : nil
    }
    
    func searchMedia(keyword: String) {
        Task {
            do {
                guard let mediaObjects = try await remoteData.searchMedia(keyword) else { return }
                let mediaItems = formatMediaDataObject(mediaObjects)
                resetSnapshot(with: mediaItems, in: 1)
            } catch {
                self.error.value = error
            }
        }
    }
    
    func formatMediaDataObject(_ dataObject: [MediaDataObject]) -> [MediaItem] {
        return dataObject.map({ MediaItem(dataObject: $0) }).filter({ $0.mediaType != nil })
    }
    
    func resetSnapshot(with items: [MediaItem], in section: Int) {
        snapshot.value = MediaSnapshot()
        snapshot.value.appendSections([section])
        snapshot.value.appendItems(items)
    }
    
}
