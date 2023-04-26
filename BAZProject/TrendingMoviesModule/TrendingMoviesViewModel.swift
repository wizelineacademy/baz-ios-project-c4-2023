//
//  TrendingMoviesViewModel.swift
//  BAZProject
//
//  Created by gescarcega on 29/03/23.
//

import UIKit

class TrendingMoviesViewModel {
    
    var movies = Box([Movie]())
    var error: Box<Error> = Box(nil)
    var remoteData: TrendingMoviesRemoteData
    
    init(movies: [Movie] = [], remoteData: TrendingMoviesRemoteData) {
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
    
    func getCellConfiguration(row: Int) -> MovieCollectionViewCellModel {
        let movie = movies.value?[row]
        return MovieCollectionViewCellModel(title: movie?.title)
    }
    
    func getRowCount() -> Int {
        return movies.value?.count ?? 0
    }
    
}
