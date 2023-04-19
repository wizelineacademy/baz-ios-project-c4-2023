//
//  MoviesInteractor.swift
//  BAZProject
//
//  Created by nmorenoa on 14/04/23.
//

import Foundation

class MoviesInteractor {
    
    // MARK: - Properties
    weak var presenter  : MoviesInteractorOutputProtocol?
    var movieApi        : Service
    
    init(movieApi: Service) {
        self.movieApi = movieApi
    }
    
}
// MARK: Extension
extension MoviesInteractor: MoviesInteractorInputProtocol{
    
    func consultServiceSearch(with word: String) {
        movieApi.getMovies(OptionMovie.searchMovie(word).request){ [weak self] (result: Result< MoviesSearchResult, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let moviesReponse):
                    self?.setMovies(with: moviesReponse)
                default:
                    self?.presenter?.setError()
                }
            }
        }
    }
    
    private func setMovies(with moviesResult: MoviesSearchResult){
        var movies              : [MovieData] = []
        if let arrMovies = moviesResult.arrMovies{
            for resultArrMovies in arrMovies{
                movies.append(MoviesViewModels(title: resultArrMovies.title ?? "",
                                               poster_path: resultArrMovies.posterPath ?? ""))
            }
            presenter?.setResponseMovies(with: movies)
        }
    }
    
}
