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
        do {
            if let initialMedia = try localData.getRecentlySearchedMedia()?.filter({ $0.mediaType != nil }) {
                var snapshot = MediaSnapshot()
                snapshot.appendSections([0])
                snapshot.appendItems(initialMedia)
                mediaSnapshot.value = snapshot
            }
        } catch {
            self.error.value = error
        }
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
    
    func searchMedia(keyword: String, scope: Int = -1) {
        let mediaType = MediaType.allCases.first(where: { $0.order == scope })
        Task {
            do {
                if let mediaObjects = try await getMedia(mediaType: mediaType, keyword: keyword) {
                    let mediaItems = formatMediaDataObject(mediaObjects, for: mediaType)
                    var snapshot = MediaSnapshot()
                    snapshot.appendSections([0])
                    snapshot.appendItems(mediaItems)
                    mediaSnapshot.value = snapshot
                }
            } catch {
                self.error.value = error
            }
        }
    }
    
    func getMedia(mediaType: MediaType?, keyword: String) async throws -> [MediaDataObject]? {
        switch mediaType {
        case .none: return try await remoteData.searchMedia(keyword)
        case .movie: return try await remoteData.searchMovies(keyword)
        case .tv: return try await remoteData.searchSeries(keyword)
        case .person: return try await remoteData.searchPeople(keyword)
        }
    }
    
    func formatMediaDataObject(_ dataObject: [MediaDataObject], for mediaType: MediaType?) -> [MediaItem] {
        if let mediaTypeToAppend = mediaType {
            return dataObject.map({
                var item = MediaItem(dataObject: $0)
                item.mediaType = mediaTypeToAppend
                return item
            }).filter({ $0.mediaType != nil })
        } else {
            return dataObject.map({ MediaItem(dataObject: $0) }).filter({ $0.mediaType != nil })
        }
    }
    
    func getDetailView(for item: MediaItem?) -> UIViewController? {
        guard let mediaItem = item, mediaItem.id != nil, mediaItem.mediaType != nil else { return nil }
        let viewModel = DetailViewModel(item: mediaItem)
        viewModel.saveRecentlySearched()
        return DetailCollectionViewController(viewModel: viewModel)
    }
    
    func getSearchScope() -> [String] {
        var titles = MediaType.allCases.sorted(by: { $0.order < $1.order}).map({ $0.groupTitle })
        titles.append("All")
        return titles
    }
    
}
