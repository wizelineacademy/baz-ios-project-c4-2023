//
//  Interactor.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 29/03/23.
//

import Foundation

/////Enumeration that stores the diferent urls used for the project
//enum serviceUrls: String {
//    case trending = "https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
//}

class Interactor: PresenterToInteractor {
    
    // MARK: Variables
    var presenter: InteractorToPresenter?
    var networkManager = NetworkManager()
    
    // MARK: Comformance PresenterToInteractorProtocol
    func getMoviesData() {
        networkManager.getTrendingMovies(page: 1){ movies, error in
            if let error = error {
                // TODO: (SDA) Presentar error
                print(error)
                return
            }
            guard let trendingMovies = movies else { return }
            self.presenter?.trendingMovies = trendingMovies
        }
        
        networkManager.getNowPlayingMovies(page: 1) { movies, error in
            if let error = error {
                // TODO: (SDA) Presentar error
                print(error)
                return
            }
            guard let nowPlayingMovies = movies else { return }
            self.presenter?.nowPlayingMovies = nowPlayingMovies
        }
        
        networkManager.getPopularMovies(page: 1){ movies, error in
            if let error = error {
                // TODO: (SDA) Presentar error
                print(error)
                return
            }
            guard let popularMovies = movies else { return }
            self.presenter?.popularMovies = popularMovies
        }
        
        networkManager.getTopRatedMovies(page: 1){ movies, error in
            if let error = error {
                // TODO: (SDA) Presentar error
                print(error)
                return
            }
            guard let topRatedMovies = movies else { return }
            self.presenter?.topRatedMovies = topRatedMovies
        }
        
        networkManager.getUpcomingMovies(page: 1){ movies, error in
            if let error = error {
                // TODO: (SDA) Presentar error
                print(error)
                return
            }
            guard let upcomingMovies = movies else { return }
            self.presenter?.upcomingMovies = upcomingMovies
        }
    }
}
