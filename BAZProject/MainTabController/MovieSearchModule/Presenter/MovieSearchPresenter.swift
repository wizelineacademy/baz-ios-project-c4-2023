//
//  MovieSearchPresenter.swift
//  BAZProject
//
//  Created by 989438 on 18/04/23.
//

import Foundation

final class MovieSearchPresenter {
    weak var view: MovieSearchViewControllerProtocol?
    var router: MovieSearchRouterProtocol?
    var interactor: MovieSearchInteractorInputProtocol?
    var movieModel: [Movie] = []
}

extension MovieSearchPresenter: MovieSearchPresenterProtocol {
    func searchMovie(withQuery query: String) {
        self.movieModel.removeAll()
        interactor?.fetchSearchMovieResults(Endpoint.search(query: query))
    }
    
    func reloadInfo() {
        view?.reloadMovieInfo()
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        let movieDetailArray: MovieDetailModel = .summary([movieModel[indexPath.row]])
        router?.presentDetailViewController(from: view, withMovie: [movieDetailArray])
    }
}

extension MovieSearchPresenter: MovieSearchInteractorOutputProtocol {
    func onReceivedSearchedList(with movieList: MoviesResult) {
        guard let movieList = movieList.results else { return }
        for movie in movieList {
            interactor?.fetchImageFrom(movie)
        }
    }
    
    func onReceivedMovie(with movie: Movie) {
        self.movieModel.append(movie)
        view?.fillMovieList()
    }
    
    func onReceived(with error: Error) {
        view?.reload(with: error)
    }
}
