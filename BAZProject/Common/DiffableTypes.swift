//
//  DiffableTypes.swift
//  BAZProject
//
//  Created by gescarcega on 01/05/23.
//

import UIKit

enum DiffableMediaObjects {
    
    typealias MediaCollectionDataSource = UICollectionViewDiffableDataSource<MediaType, MediaItem>
    typealias MediaTableDataSource = UITableViewDiffableDataSource<MediaType, MediaItem>
    typealias MediaSnapshot = NSDiffableDataSourceSnapshot<MediaType, MediaItem>
    
    static func formatMediaDataObject(_ dataObject: [MediaDataObject]) -> [MediaType : [MediaItem]] {
        let mediaItems = dataObject.map({ MediaItem(dataObject: $0) }).filter({ $0.mediaType != nil })
        return Dictionary(grouping: mediaItems, by: { $0.mediaType! })
    }
    
    static func getSnapshotWithDictionary(dctItems: [MediaType : [MediaItem]]) -> MediaSnapshot {
        var snapshot = MediaSnapshot()
        let sorted = dctItems.sorted(by: { $0.key.order < $1.key.order })
        sorted.forEach { (key, value) in
            snapshot.appendSections([key])
            snapshot.appendItems(value)
        }
        return snapshot
    }
    
}
