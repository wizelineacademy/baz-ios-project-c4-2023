//
//  FavoriteViewControllerMock.swift
//  BAZProject
//
//  Created by Manuel S on 01/05/23.
//

import Foundation
@testable import BAZProject

final class FavoritesViewModelMock: FavoritesViewModel {

    var movies = [Movie]()
    
    override func getMovieCount() -> Int {
        movies.count
    }
}
