//
//  TrendingMediaViewModel.swift
//  BAZProject
//
//  Created by gescarcega on 29/03/23.
//

import UIKit

class TrendingMediaViewModel {
    
    typealias MediaCollectionDataSource = UICollectionViewDiffableDataSource<TrendingMediaSection, MediaItem>
    typealias MediaCollectionSnapShot = NSDiffableDataSourceSnapshot<TrendingMediaSection, MediaItem>
    typealias MediaCollectionCellRegistration = UICollectionView.CellRegistration<MediaCollectionViewCell, MediaItem>
    
    var error: Box<Error?> = Box(nil)
    var remoteData: TrendingMediaRemoteData
    private var mediaSnapshot = Box(MediaCollectionSnapShot())
    
    init(remoteData: TrendingMediaRemoteData) {
        self.remoteData = remoteData
    }
    
    func bindSnapshot(_ handler: @escaping (MediaCollectionSnapShot) -> Void) {
        mediaSnapshot.bind(handler)
    }
    
    func bindError(_ handler: @escaping (Error?) -> Void) {
        error.bind(handler)
    }
    
    func loadData() {
        Task {
            do {
                async let trendingMedia = remoteData.getMediaItems(section: .trending)
                async let nowPlayingMedia = remoteData.getMediaItems(section: .nowPlaying)
                async let popularMedia = remoteData.getMediaItems(section: .popular)
                async let topRatedMedia = remoteData.getMediaItems(section: .topRated)
                async let upcomingMedia = remoteData.getMediaItems(section: .upcoming)
                let dictionary = try await formatMediaDataObject(trending: trendingMedia, popular: popularMedia, upcoming: upcomingMedia, topRated: topRatedMedia, nowPlaying: nowPlayingMedia)
                setSnapshotWithDictionary(dctItems: dictionary)
            } catch {
                self.error.value = error
            }
        }
    }
    
    func getGroupTitle(for section: Int) -> String? {
        return mediaSnapshot.value.sectionIdentifiers[section].title
    }
    
    func formatMediaDataObject(trending: [MediaDataObject]?, popular: [MediaDataObject]?, upcoming: [MediaDataObject]?, topRated: [MediaDataObject]?, nowPlaying: [MediaDataObject]?) -> [TrendingMediaSection: [MediaItem]] {
        var dictionary = [TrendingMediaSection: [MediaItem]]()
        if let trending = trending {
            dictionary[.trending] = trending.map({ MediaItem(dataObject: $0) }).filter({ $0.mediaType != nil })
        }
        if let popular = popular {
            dictionary[.popular] = popular.map({ var item = MediaItem(dataObject: $0); item.mediaType = .movie; return item })
        }
        if let upcoming = upcoming {
            dictionary[.upcoming] = upcoming.map({ var item = MediaItem(dataObject: $0); item.mediaType = .movie; return item })
        }
        if let topRated = topRated {
            dictionary[.topRated] = topRated.map({ var item = MediaItem(dataObject: $0); item.mediaType = .movie; return item })
        }
        if let nowPlaying = nowPlaying {
            dictionary[.nowPlaying] = nowPlaying.map({ var item = MediaItem(dataObject: $0); item.mediaType = .movie; return item })
        }
        return dictionary
    }
    
    func setSnapshotWithDictionary(dctItems: [TrendingMediaSection : [MediaItem]]) {
        let sorted = dctItems.sorted(by: { $0.key.rawValue < $1.key.rawValue })
        var snapshot = MediaCollectionSnapShot()
        sorted.forEach { (key, value) in
            snapshot.appendSections([key])
            snapshot.appendItems(value)
        }
        mediaSnapshot.value = snapshot
    }
    
    func getDetailView(for item: MediaItem?) -> UIViewController? {
        guard let mediaItem = item, mediaItem.id != nil, mediaItem.mediaType != nil else { return nil }
        let detailViewModel = DetailViewModel(item: mediaItem)
        return DetailCollectionViewController(viewModel: detailViewModel)
    }
    
}
