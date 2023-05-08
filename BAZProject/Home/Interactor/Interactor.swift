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
                self.presenter?.showAlert(title: "Success", message: "Trending movies has been consulted...")
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
        
//        networkManager.getMovies(endpoint: .cast(movieId: 447365)) { (result: CastResponse?, error) in
//            if let error = error {
//                print("TENEMOS ERROR EN LA CONSULTA DE CAST")
//                return
//            } else if let resultado = result {
//                print("TENEMOS RESPUESTA EN EL CAST(REPARTO):")
//                print(resultado)
//            }
//        }
//
//        networkManager.getMovies(endpoint: .similar(movieId: 603)) { (result: MovieApiResponse?, error) in
//            if let error = error {
//                print("TENEMOS ERROR EN LA CONSULTA DE SIMILAR")
//                return
//            } else if let resultado = result {
//                print("TENEMOS RESPUESTA EN LAS PELÍCULAS SIMILARES:")
//                print(resultado)
//            }
//        }
//
//        networkManager.getMovies(endpoint: .recommendations(movieId: 603)){(result: MovieApiResponse?, error) in
//            if let error = error {
//                print("TENEMOS ERROR EN LA CONSULTA DE RECOMMENDATIONS")
//                return
//            } else if let resultado = result {
//                print("TENEMOS RESPUESTA EN LAS PELÍCULAS RECOMENDADAS:")
//                print(resultado)
//            }
//        }
//
//        networkManager.getMovies(endpoint: .reviews(movieId: 603)){(result: ReviewsResponse?, error) in
//            if let error = error {
//                print("TENEMOS ERROR EN LA CONSULTA DE REVIEWS")
//                return
//            } else if let resultado = result {
//                print("TENEMOS RESPUESTA EN LAS REVIEWS:")
//                print(resultado)
//            }
//        }
        
//        networkManager.getMovies(endpoint: .multi(searching: "pine")){(result: MediaApiResponse?, error)in
//            if let error = error {
//                print("TENEMOS ERROR EN LA CONSULTA MÚLTIPLE")
//                return
//            } else if let resultado = result {
//                print("TENEMOS RESPUESTA EN LA BÚSQUEDA MÚLTIPLE:")
//                print(resultado)
//            }
//        }
        
//        networkManager.getMovies(endpoint: .multi(searching: "pine")){(result: MultipleSearchResponse?, error) in
//            if let error = error {
//                print("TENEMOS ERROR EN LA CONSULTA MÚLTIPLE")
//                return
//            } else if let resultado = result {
//                print("TENEMOS RESPUESTA EN LA BÚSQUEDA MÚLTIPLE:")
//                print(resultado)
//            }
//        }
    }
}
