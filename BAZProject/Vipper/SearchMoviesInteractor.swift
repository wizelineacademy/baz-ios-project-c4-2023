//
//  SearchMoviesInteractor.swift
//  BAZProject
//
//  Created by nmorenoa on 14/04/23.
//

import Foundation

class SearchMoviesInteractor {
    
    // MARK: - Properties
    weak var presenter  : SearchMoviesInteractorOutputProtocol?
    var movieApi        : Service
    
    init(movieApi: Service) {
        self.movieApi = movieApi
    }
    
}
// MARK: Extension
extension SearchMoviesInteractor: SearchMoviesInteractorInputProtocol{
    
    /**
     this function calls the service getMovies
    
     - Parameter word: search word
     - Returns:
       - success: return The type of the value to decode from the supplied JSON object.
       - error: returns the service error.
    */
    func consultServiceSearch(with word: String) {
        movieApi.getMovies(OptionMovie.searchMovie(word).request){ [weak self] (result: Result< MoviesSearchResult, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let moviesReponse):
                    if moviesReponse.movies?.count ?? 0 > 0{
                        self?.setMovies(with: moviesReponse.movies)
                    }else{
                        self?.presenter?.setError()
                    }
                default:
                    self?.presenter?.setError()
                }
            }
        }
    }
    
    /**
     this function creates an array of MoviesViewModels
     */
    func setMovies(with moviesResult: [Movie]?){
        var movies              : [MovieData] = []
        for resultArrMovies in moviesResult ?? [Movie](){
            movies.append(MoviesViewModels(title: resultArrMovies.title ?? "",
                                           poster_path: resultArrMovies.posterPath ?? "",
                                           original_title: resultArrMovies.originalTitle ?? "",
                                           id: resultArrMovies.id ?? 0,
                                           overview: resultArrMovies.overview ?? ""))
        }
        presenter?.setResponseMovies(with: movies)
    }
    
}
