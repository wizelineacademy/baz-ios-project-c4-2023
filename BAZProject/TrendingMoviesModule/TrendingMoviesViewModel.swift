//
//  TrendingMoviesViewModel.swift
//  BAZProject
//
//  Created by gescarcega on 29/03/23.
//

import UIKit

class TrendingMoviesViewModel {
    
    typealias MediaCollectionDataSource = UICollectionViewDiffableDataSource<MediaType, MediaItem>
    typealias MediaCollectionSnapShot = NSDiffableDataSourceSnapshot<MediaType, MediaItem>
    typealias MediaCollectionCellRegistration = UICollectionView.CellRegistration<MediaCollectionViewCell, MediaItem>
    
    var error: Box<Error> = Box(nil)
    var remoteData: TrendingMoviesRemoteData
    private var mediaSnapshot = Box(MediaCollectionSnapShot())
    
    init(dataObjects: [MediaDataObject] = [], remoteData: TrendingMoviesRemoteData) {
        self.remoteData = remoteData
        self.setSnapshotWithDictionary(dctItems: self.formatMediaDataObject(dataObjects))
    }
    
    func bindMovies(_ handler: @escaping () -> Void) {
        mediaSnapshot.bind(handler)
    }
    
    func bindError(_ handler: @escaping () -> Void) {
        error.bind(handler)
    }
    
    func getMovies() {
        Task {
            do {
                guard let movieArray = try await remoteData.getMovies() else { return }
                let formatted = formatMediaDataObject(movieArray)
                setSnapshotWithDictionary(dctItems: formatted)
            } catch {
                self.error.value = error
            }
        }
    }
    
    func getError() -> String? {
        error.value?.localizedDescription
    }
    
    func getCellConfiguration(item movie: MediaItem) -> MediaCollectionViewCellModel {
        var subtitle: String?
        var rated = false
        if let releaseDate = movie.releaseDate, releaseDate > Date() {
            let stringFormatter = DateFormatter()
            stringFormatter.dateStyle = .short
            stringFormatter.timeStyle = .none
            stringFormatter.locale = Locale.current
            subtitle = stringFormatter.string(from: releaseDate)
        } else if let average = movie.rating, average != 0 {
            subtitle = String(round(average * 10) / 10)
            rated = true
        }
        
        return MediaCollectionViewCellModel(title: movie.title ?? "", subtitle: subtitle, image: movie.posterPath ?? "", rated: rated, defaultImage: movie.mediaType?.defaultImage)
    }
    
    
    func getDataSnapshot() -> NSDiffableDataSourceSnapshot<MediaType, MediaItem> {
        return mediaSnapshot.value ?? NSDiffableDataSourceSnapshot<MediaType, MediaItem>()
    }
    
    func getGroupTitle(for section: Int) -> String? {
        return mediaSnapshot.value?.sectionIdentifiers[section].groupTitle
    }
    
    func formatMediaDataObject(_ dataObject: [MediaDataObject]) -> [MediaType : [MediaItem]] {
        let mediaItems = dataObject.map({ MediaItem(dataObject: $0) }).filter({ $0.mediaType != nil })
        return Dictionary(grouping: mediaItems, by: { $0.mediaType! })
    }
    
    func setSnapshotWithDictionary(dctItems: [MediaType : [MediaItem]]) {
        let sorted = dctItems.sorted(by: { $0.key.order < $1.key.order })
        sorted.forEach { (key, value) in
            mediaSnapshot.value?.appendSections([key])
            mediaSnapshot.value?.appendItems(value)
        }
    }
    
}

fileprivate extension MediaItem {
    init(dataObject: MediaDataObject) {
        self.mediaType = MediaType(dataObject.mediaType)
        self.rating = dataObject.voteAverage
        self.id = dataObject.id
        self.title = dataObject.title ?? dataObject.name
        self.posterPath = dataObject.posterPath ?? dataObject.profilePath
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.releaseDate = dateFormatter.date(from: dataObject.releaseDate ?? "")
    }
}
