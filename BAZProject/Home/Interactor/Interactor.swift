//
//  Interactor.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 29/03/23.
//

import Foundation

class Interactor: PresenterToInteractor {
    
    // MARK: Variables
    var presenter: InteractorToPresenter?
    var networkManager = NetworkManager()
    
    // MARK: Comformance PresenterToInteractorProtocol
    func getMoviesData() {
        
        ///Getting Trending Movies
        networkManager.getMovies(endpoint: .trending(page: 1)) { (result: MovieApiResponse?, error) in
            if let error = error {
                // TODO: (SDA) Presentar error
                print(error)
                return
            } else if let trendingMovies = result?.movies{
                self.presenter?.trendingMovies = trendingMovies
            }
        }
        
        ///Getting NowPlaying Movies
        networkManager.getMovies(endpoint: .nowPlaying(page: 1)) { (result: MovieApiResponse?, error) in
            if let error = error {
                // TODO: (SDA) Presentar error
                print(error)
                return
            } else if let nowPlayingMovies = result?.movies{
                self.presenter?.nowPlayingMovies = nowPlayingMovies
            }
        }
        
        ///Getting Pupular Movies
        networkManager.getMovies(endpoint: .pupular(page: 1)) { (result: MovieApiResponse?, error) in
            if let error = error {
                // TODO: (SDA) Presentar error
                print(error)
                return
            } else if let popularMovies = result?.movies{
                self.presenter?.popularMovies = popularMovies
            }
        }
        
        ///Getting Top Rated Movies
        networkManager.getMovies(endpoint: .topRated(page: 1)) { (result: MovieApiResponse?, error) in
            if let error = error {
                // TODO: (SDA) Presentar error
                print(error)
                return
            } else if let topRatedMovies = result?.movies{
                self.presenter?.topRatedMovies = topRatedMovies
            }
        }
        
        ///Getting NowPlaying Movies
        networkManager.getMovies(endpoint: .upcoming(page: 1)) { (result: MovieApiResponse?, error) in
            if let error = error {
                // TODO: (SDA) Presentar error
                print(error)
                return
            } else if let upcomingMovies = result?.movies{
                self.presenter?.upcomingMovies = upcomingMovies
            }
        }
    }
}
