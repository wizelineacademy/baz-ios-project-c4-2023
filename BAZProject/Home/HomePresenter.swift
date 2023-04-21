//
//  HomePresenter.swift
//  BAZProject
//
//  Created by Carlos Garcia on 20/04/23.
//  
//

import Foundation
import UIKit

class HomePresenter  {
    
    // MARK: Properties
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var router: HomeRouterProtocol?
    
    var arrScrollingSections = [MovieListCollectionView]()
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
    
    func numberOfRows() -> Int {
        interactor?.getMovieFoundCount() ?? 0
    }
    
    func getSearchMovie(for indexPath: IndexPath) -> MovieInfo? {
        return nil
    }
    
    func fetchMovieDetails(for indexPath: IndexPath) {
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func updateMoviesFound(_ movies: [MovieFoundInfo]?) {
        self.view?.showMoviesFound(movies)
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

