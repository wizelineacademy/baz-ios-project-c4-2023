//
//  TrendingMoviesViewModel.swift
//  BAZProject
//
//  Created by gescarcega on 29/03/23.
//

import UIKit

class TrendingMoviesViewModel {
    
    var movies = Box([[MediaItem]]())
    var error: Box<Error> = Box(nil)
    var remoteData: TrendingMoviesRemoteData
    
    init(movies: [[MediaItem]] = [], remoteData: TrendingMoviesRemoteData) {
        self.movies.value = movies
        self.remoteData = remoteData
    }
    
    func bindMovies(_ handler: @escaping () -> Void) {
        movies.bind(handler)
    }
    
    func bindError(_ handler: @escaping () -> Void) {
        error.bind(handler)
    }
    
    func getMovies() {
        Task {
            do {
                guard let movieArray = try await remoteData.getMovies() else { return }
                movies.value = formatMediaDataObject(movieArray)
            } catch {
                self.error.value = error
            }
        }
    }
    
    func getError() -> String? {
        error.value?.localizedDescription
    }
    
    func getCellConfiguration(indexPath: IndexPath) -> MediaCollectionViewCellModel {
        let movie = movies.value?[indexPath.section][indexPath.row]
        var subtitle: String?
        var rated = false
        if let releaseDate = movie?.releaseDate, releaseDate > Date() {
            let stringFormatter = DateFormatter()
            stringFormatter.dateStyle = .short
            stringFormatter.timeStyle = .none
            stringFormatter.locale = Locale.current
            subtitle = stringFormatter.string(from: releaseDate)
        } else if let average = movie?.rating, average != 0 {
            subtitle = String(round(average * 10) / 10)
            rated = true
        }
        
        return MediaCollectionViewCellModel(title: movie?.title ?? "", subtitle: subtitle, image: movie?.posterPath ?? "", rated: rated, defaultImage: movie?.mediaType?.defaultImage)
    }
    
    func getRowCount(for section: Int) -> Int {
        return movies.value?[section].count ?? 0
    }
    
    func formatMediaDataObject(_ dataObject: [MediaDataObject]) -> [[MediaItem]] {
        let mediaItems = dataObject.map({ MediaItem(dataObject: $0) })
        return mediaItems.grouped(by: { $0.mediaType })
    }
    
    func getSectionCount() -> Int {
        return movies.value?.count ?? 0
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

extension Sequence {
    
    public func grouped<T: Equatable>(by block: (Element) -> T) -> [[Element]] {
        return reduce(into: [], { partialResult, element in
            if let lastElement = partialResult.last?.last,
               block(lastElement) == block(element) {
                partialResult[partialResult.index(before: partialResult.endIndex)].append(element)
            } else {
                partialResult.append([element])
            }
        })
    }
    
}
