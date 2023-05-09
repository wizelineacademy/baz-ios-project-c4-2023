//
//  TrendingInteractorMock.swift
//  BAZProjectTests
//
//  Created by Ben Frank V. on 25/04/23.
//

import Foundation

class TrendingInteractorMock: TrendingInteractorInputProtocol {
    var presenter: TrendingInteractorOutputProtocol?
    
    var remoteDatamanager: TrendingRemoteDataManagerInputProtocol?
    
    var entity: TrendingEntity?
    
    func fetchMovies() {
    }
    
    
}

extension TrendingInteractorMock: TrendingRemoteDataManagerOutputProtocol {
    func handleGetMovies(_ result: [Movie]) {
        self.entity = moviesData(entity, typeIn: .trendingMovies(result))
        remoteDatamanager?.getNowPlaying()
    }
    
    func handleGetNowPlaying(_ result: [Movie]) {
        //<#code#>
    }
    
    func handleGetPopular(_ result: [Movie]) {
        //<#code#>
    }
    
    func handleGetTopRated(_ result: [Movie]) {
        //<#code#>
    }
    
    func handleGetUpcoming(_ result: [Movie]) {
        self.entity = moviesData(entity, typeIn: .upcoming(result))
        guard let entity = self.entity else { return }
        presenter?.onReceivedMovies(entity)
    }
    
    func handleGetErrorServiceMovies(_ error: Error) {
        presenter?.showMoviesError(error)
    }
    
    func moviesData(_ entity: TrendingEntity?, typeIn: ListSectionMovieHome) -> TrendingEntity?{
        var localEntity = entity
        switch typeIn {
        case .trendingMovies(let movies):
            localEntity?.movieDetailData.trendingMovies = ListSectionMovieHome.trendingMovies(movies)
        case .nowPlayingMovies(let movies):
            localEntity?.movieDetailData.nowPlayingMovies = ListSectionMovieHome.nowPlayingMovies(movies)
        case .popular(let movies):
            localEntity?.movieDetailData.popular = ListSectionMovieHome.popular(movies)
        case .topRated(let movies):
            localEntity?.movieDetailData.topRated = ListSectionMovieHome.topRated(movies)
        case .upcoming(let movies):
            localEntity?.movieDetailData.upcoming = ListSectionMovieHome.upcoming(movies)
        }
        return localEntity
    }
    
}
