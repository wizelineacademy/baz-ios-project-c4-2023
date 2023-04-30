//
//  SearchViewModel.swift
//  BAZProject
//
//  Created by gescarcega on 29/04/23.
//

import UIKit

class SearchViewModel {
    
    typealias MediaCollectionDataSource = UICollectionViewDiffableDataSource<MediaType, MediaItem>
    typealias MediaCollectionSnapShot = NSDiffableDataSourceSnapshot<MediaType, MediaItem>
    
    var remoteData: SearchRemoteData
    
    init(remoteData: SearchRemoteData) {
        self.remoteData = remoteData
    }
    
}
