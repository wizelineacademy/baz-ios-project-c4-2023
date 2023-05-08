//
//  FavouritesViewModel.swift
//  BAZProject
//
//  Created by gescarcega on 08/05/23.
//

import UIKit

class FavouritesViewModel {
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, MediaItem>
    
    private var localData: FavouritesLocalData
    private var error: Box<Error?> = Box(nil)
    private var snapshot = Box(Snapshot())
    
    init(localData: FavouritesLocalData) {
        self.localData = localData
    }
    
    func bindError(_ listener: @escaping (Error?) -> Void) {
        error.bind(listener)
    }
    
    func bindSnapshot(_ listener: @escaping (Snapshot) -> Void) {
        snapshot.bind(listener)
    }
    
    func loadFavourites() {
        if let favourites = getLocalData() {
            var auxSnapshot = Snapshot()
            auxSnapshot.appendSections([0])
            auxSnapshot.appendItems(favourites, toSection: 0)
            snapshot.value = auxSnapshot
        }
    }
    
    func removeFavourite(_ item: MediaItem) {
        do {
            try localData.removeFavourite(item)
            snapshot.value.deleteItems([item])
        } catch {
            self.error.value = error
        }
    }
    
    func getLocalData() -> [MediaItem]? {
        do {
            return try localData.getFavourites()
        } catch {
            self.error.value = error
            return  nil
        }
    }
    
    func getDetailView(for item: MediaItem?) -> UIViewController? {
        guard let mediaItem = item, mediaItem.id != nil, mediaItem.mediaType != nil else { return nil }
        let detailViewModel = DetailViewModel(item: mediaItem)
        return DetailCollectionViewController(viewModel: detailViewModel)
    }
}
