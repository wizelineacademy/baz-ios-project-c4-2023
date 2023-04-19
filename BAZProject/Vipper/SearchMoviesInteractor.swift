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
    
    func consultServiceSearch(with word: String) {
        movieApi.getMovies(OptionMovie.searchMovie(word).request){ [weak self] (result: Result< MoviesSearchResult, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let moviesReponse):
                    if moviesReponse.arrMovies?.count ?? 0 > 0{
                        self?.setMovies(with: moviesReponse.arrMovies)
                    }else{
                        self?.presenter?.setError()
                    }
                default:
                    self?.presenter?.setError()
                }
            }
        }
    }
    
    private func setMovies(with moviesResult: [Movie]?){
        var movies              : [MovieData] = []
        for resultArrMovies in moviesResult ?? [Movie](){
            movies.append(MoviesViewModels(title: resultArrMovies.title ?? "",
                                           poster_path: resultArrMovies.posterPath ?? ""))
        }
        presenter?.setResponseMovies(with: movies)
    }
    
}
