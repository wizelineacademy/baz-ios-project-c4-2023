//
//  DetailInteractorMock.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 08/05/23.
//

import Foundation

@testable import BAZProject

enum DetailInteractorMockCalls {
    case saveFavoriteMovie
    case deleteToFavoriteMovie
    case fetchMovieDetail
    case movieDetailFetched
}

final class DetailInteractorMock: MovieDetailInteractorInputProtocol, MovieDetailRemoteDataManagerOutputProtocol {

    var presenter: MovieDetailInteractorOutputProtocol?
    var data: MovieDetail?
    var saveData: MovieFavorites = MovieFavorites()
    var remoteDatamanager: MovieDetailRemoteDataManagerInputProtocol?
    var detailCalls: [DetailInteractorMockCalls] = []
    
    func saveFavoriteMovie(of movieId: Int?) {
        detailCalls.append(.saveFavoriteMovie)
    }
    
    func deleteToFavoriteMovie(of movieId: Int?) {
        detailCalls.append(.deleteToFavoriteMovie)
    }
    
    func fetchMovieDetail(of movieId: Int?) {
        detailCalls.append(.fetchMovieDetail)
    }
    
    func movieDetailFetched(with movieDetail: MovieDetail) {
        detailCalls.append(.movieDetailFetched)
    }
    
}
