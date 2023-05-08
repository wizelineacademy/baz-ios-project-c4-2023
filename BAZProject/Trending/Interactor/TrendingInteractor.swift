//
//  TrendingInteractor.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//  
//

import Foundation

class TrendingInteractor: TrendingInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: TrendingInteractorOutputProtocol?
    var remoteDatamanager: TrendingRemoteDataManagerInputProtocol?
    var entity: TrendingEntity?

    func getNavTitle() -> String?{
        return entity?.strNavBarTitle
    }
    
    func fetchMovies() {
        remoteDatamanager?.getMoviesTrending()
    }
}

extension TrendingInteractor: TrendingRemoteDataManagerOutputProtocol {
    func handleGetMovies(_ result: [Movie]) {
        self.entity = moviesData(entity, typeIn: .trendingMovies(result))
        remoteDatamanager?.getNowPlaying()
        
    }
    
    func handleGetNowPlaying(_ result: [Movie]) {
        self.entity = moviesData(entity, typeIn: .nowPlayingMovies(result))
        remoteDatamanager?.getPopular()
        
    }
    
    func handleGetPopular(_ result: [Movie]) {
        self.entity = moviesData(entity, typeIn: .popular(result))
        remoteDatamanager?.getTopRated()
    }
    
    func handleGetTopRated(_ result: [Movie]) {
        self.entity = moviesData(entity, typeIn: .topRated(result))
        remoteDatamanager?.getUpcoming()
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
