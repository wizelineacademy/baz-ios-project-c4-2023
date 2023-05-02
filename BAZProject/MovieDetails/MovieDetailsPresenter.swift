//
//  MovieDetailsPresenter.swift
//  BAZProject
//
//  Created by Carlos Garcia on 21/04/23.
//  
//

import Foundation
import UIKit

class MovieDetailsPresenter  {
    
    // MARK: Properties
    weak var view: MovieDetailsViewProtocol?
    var interactor: MovieDetailsInteractorInputProtocol?
    var router: MovieDetailsRouterProtocol?
    var movie: MovieInfo?
    
    init(interactor: MovieDetailsInteractorInputProtocol,
         router: MovieDetailsRouterProtocol,
         movie: MovieInfo?) {
        self.interactor = interactor
        self.router = router
        self.movie = movie
    }
    
}

extension MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    func present() {
        self.router?.present(presenter: self)
    }
    
    func attach(view: MovieDetailsViewProtocol?) {
        self.view = view
    }
    
    // TODO: implement presenter methods
    func viewDidLoad() {
        view?.setNavigationTitle(for: interactor?.getNavTitle())
        
        guard let movie = self.movie else { return }
        view?.showMovieData(movie)
    }
}

extension MovieDetailsPresenter: MovieDetailsInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
