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
        // TODO: Erase the next lines
//        networkManager.getTrendingMovies(page: 1){ movies, error in
//            if let error = error {
//                // TODO: (SDA) Presentar error
//                print(error)
//                return
//            }
//            guard let trendingMovies = movies else { return }
//            self.presenter?.trendingMovies = trendingMovies
//        }
        
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
        
//        networkManager.getNowPlayingMovies(page: 1) { movies, error in
//            if let error = error {
//                // TODO: (SDA) Presentar error
//                print(error)
//                return
//            }
//            guard let nowPlayingMovies = movies else { return }
//            self.presenter?.nowPlayingMovies = nowPlayingMovies
//        }
        
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
        
//        networkManager.getPopularMovies(page: 1){ movies, error in
//            if let error = error {
//                // TODO: (SDA) Presentar error
//                print(error)
//                return
//            }
//            guard let popularMovies = movies else { return }
//            self.presenter?.popularMovies = popularMovies
//        }
        
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
        
//        networkManager.getTopRatedMovies(page: 1){ movies, error in
//            if let error = error {
//                // TODO: (SDA) Presentar error
//                print(error)
//                return
//            }
//            guard let topRatedMovies = movies else { return }
//            self.presenter?.topRatedMovies = topRatedMovies
//        }
        
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
        
//        networkManager.getUpcomingMovies(page: 1){ movies, error in
//            if let error = error {
//                // TODO: (SDA) Presentar error
//                print(error)
//                return
//            }
//            guard let upcomingMovies = movies else { return }
//            self.presenter?.upcomingMovies = upcomingMovies
//        }
    }
}
