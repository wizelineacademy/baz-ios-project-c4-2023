//
//  TrendingMoviesViewModel.swift
//  BAZProject
//
//  Created by gescarcega on 29/03/23.
//

import UIKit

class TrendingMoviesViewModel {
    
    var movies = Box([MediaDataObject]())
    var error: Box<Error> = Box(nil)
    var remoteData: TrendingMoviesRemoteData
    
    init(movies: [MediaDataObject] = [], remoteData: TrendingMoviesRemoteData) {
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
                movies.value = try await remoteData.getMovies()
            } catch {
                self.error.value = error
            }
        }
    }
    
    func getError() -> String? {
        error.value?.localizedDescription
    }
    
    func getCellConfiguration(row: Int) -> MediaItem {
        let movie = movies.value?[row]
        var rating: String? = nil
        if let average = movie?.voteAverage {
            rating = String(round(average * 10) / 10)
        }
        let mediaModel = MediaItem(id: movie?.id, title: movie?.title, rating: rating, mediaType: MediaType(movie?.mediaType))
        return mediaModel
    }
    
    func getRowCount() -> Int {
        return movies.value?.count ?? 0
    }
    
}
