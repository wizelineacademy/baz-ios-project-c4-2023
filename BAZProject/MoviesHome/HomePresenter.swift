//
//  HomePresenter.swift
//  BAZProject
//
//  Created by Carlos Garcia on 20/04/23.
//  
//

import UIKit

class HomePresenter  {
    
    // MARK: Properties
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var router: HomeRouterProtocol?
    
    var arrScrollingSections = [MovieListCollectionView]()
    var isNewSearch: Bool = false
}

extension HomePresenter: HomePresenterProtocol {
    func fetchMovies(for text: String?) {
        guard let text = text else {
            return
        }
        interactor?.searchMovies(for: text)
    }
    
    func getData() {
        interactor?.setSectionsData()
        view?.setNavigationTitle(for: interactor?.getNavTitle())
    }
    
    func fetchMovies() {
        for scrollingSection in arrScrollingSections {
            interactor?.fetchMovies(for: scrollingSection.section)
        }
    }
    
    func numberOfRowsForSearch() -> Int? {
        interactor?.getMovieFoundCount()
    }
    
    func resetSearch() {
        isNewSearch = true
        interactor?.resetSearch()
    }
    
    func getMovieSearch(for indexPath: IndexPath) -> MovieFoundInfo? {
        interactor?.getMovieFound(for: indexPath.row)
    }
    
    func goToMovieDetails(for indexPath: IndexPath) {
        if let movieFound = interactor?.getMovieFound(for: indexPath.row) {
            let movie: MovieInfo = MovieFoundAdapter(movieFound)
            router?.goToMovieDetailsView(movie, parent: self.view)
        }
    }
    
    func goToFavoriteMovies() {
        router?.goToFavoriteMoviesView(parent: self.view)
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func updateMoviesFound(_ movies: [MovieFoundInfo]?) {
        if (movies?.count ?? 0 > 0) || (isNewSearch) {
            self.view?.reloadSearchResults()
        } else {
            self.view?.showEmptyResults()
        }
        isNewSearch = false
    }
    
    func updateMovies(_ movies: [MovieInfo]?, in section: Int) {
        guard let movies = movies else {
            return
        }
        arrScrollingSections[section].setMovies(movies)
    }
    
    func updateSectionsData(_ sections: [MovieSection]) {
        for (index, section) in sections.enumerated() {
            let collectionSection = MovieListCollectionView(frame: .infinite)
            collectionSection.setTitle(section.strTitle)
            collectionSection.section = index
            collectionSection.delegate = self
            arrScrollingSections.append(collectionSection)
        }
        self.view?.updateSectionsData(arrScrollingSections)
    }
}

extension HomePresenter: MovieListCollectionViewDelegate {
    func movieListCollectionView(_ collectionView: MovieListCollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = interactor?.getMovie(for: indexPath) {
            router?.goToMovieDetailsView(movie, parent: self.view)
        }
    }
}
