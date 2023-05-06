//
//  TrendingMediaViewModel.swift
//  BAZProject
//
//  Created by gescarcega on 29/03/23.
//

import UIKit

class TrendingMediaViewModel {
    
    typealias MediaCollectionDataSource = UICollectionViewDiffableDataSource<MediaType, MediaItem>
    typealias MediaCollectionSnapShot = NSDiffableDataSourceSnapshot<MediaType, MediaItem>
    typealias MediaCollectionCellRegistration = UICollectionView.CellRegistration<MediaCollectionViewCell, MediaItem>
    
    var error: Box<Error?> = Box(nil)
    var remoteData: TrendingMediaRemoteData
    private var mediaSnapshot = Box(MediaCollectionSnapShot())
    
    init(dataObjects: [MediaDataObject] = [], remoteData: TrendingMediaRemoteData) {
        self.remoteData = remoteData
        self.setSnapshotWithDictionary(dctItems: self.formatMediaDataObject(dataObjects))
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
                guard let mediaArray = try await remoteData.getMediaItems() else { return }
                let formattedMedia = formatMediaDataObject(mediaArray)
                setSnapshotWithDictionary(dctItems: formattedMedia)
            } catch {
                self.error.value = error
            }
        }
    }

    func getCellConfiguration(item: MediaItem) -> MediaCollectionViewCellModel {
        var subtitle: String?
        var rated = false
        if let releaseDate = item.releaseDate, releaseDate > Date() {
            subtitle = DateFormatter.common.string(from: releaseDate)
        } else if let average = item.rating, average != 0 {
            subtitle = String(round(average * 10) / 10)
            rated = true
        }
        return MediaCollectionViewCellModel(title: item.title, subtitle: subtitle, image: item.posterPath, rated: rated, defaultImage: item.mediaType?.defaultImage)
    }
    
    func getGroupTitle(for section: Int) -> String? {
        return mediaSnapshot.value.sectionIdentifiers[section].groupTitle
    }
    
    func formatMediaDataObject(_ dataObject: [MediaDataObject]) -> [MediaType : [MediaItem]] {
        let mediaItems = dataObject.map({ MediaItem(dataObject: $0) }).filter({ $0.mediaType != nil })
        return Dictionary(grouping: mediaItems, by: { $0.mediaType! })
    }
    
    func setSnapshotWithDictionary(dctItems: [MediaType : [MediaItem]]) {
        let sorted = dctItems.sorted(by: { $0.key.order < $1.key.order })
        var snapshot = MediaCollectionSnapShot()
        sorted.forEach { (key, value) in
            snapshot.appendSections([key])
            snapshot.appendItems(value)
        }
        mediaSnapshot.value = snapshot
    }
    
}