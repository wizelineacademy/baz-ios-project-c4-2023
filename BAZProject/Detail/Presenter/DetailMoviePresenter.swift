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
    var mainAnalytics: MainAnalyticsProtocol?
    
}

extension DetailMoviePresenter: DetailMoviePresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
        view?.setNavigationTitle(for: interactor?.getNavTitle())
    }
}

extension DetailMoviePresenter: DetailMovieInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
