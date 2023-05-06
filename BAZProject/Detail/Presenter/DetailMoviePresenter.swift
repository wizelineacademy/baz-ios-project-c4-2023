//
//  DetailMoviePresenter.swift
//  BAZProject
//
//  Created by Ben Frank V. on 03/05/23.
//  
//

import Foundation
import UIKit

class DetailMoviePresenter  {
    
    // MARK: Properties
    weak var view: DetailMovieViewProtocol?
    var interactor: DetailMovieInteractorInputProtocol?
    var router: DetailMovieRouterProtocol?
    
}

extension DetailMoviePresenter: DetailMoviePresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
    
    func willFetchDetailsMovie() {
        Loader.start()
        interactor?.fetchDetailsMovie()
    }
}

extension DetailMoviePresenter: DetailMovieInteractorOutputProtocol {
    func onReceivedMovieDetails(_ result: DetailMovieEntity) {
      //  <#code#>
    }
    
    func showSearchedMoviesError(_ error: Error) {
       // <#code#>
    }
    
    // TODO: implement interactor output methods
}
