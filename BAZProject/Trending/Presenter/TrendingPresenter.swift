//
//  TrendingPresenter.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//  
//

import Foundation
import UIKit

class TrendingPresenter  {
    
    // MARK: Properties
    weak var view: TrendingViewProtocol?
    var interactor: TrendingInteractorInputProtocol?
    var router: TrendingRouterProtocol?
    
    var entity = TrendingEntity()
    
}

extension TrendingPresenter: TrendingPresenterProtocol {
    
    // TODO: implement presenter methods
    func viewDidLoad() {
        view?.setNavigationTitle(for: interactor?.getNavTitle())
        view?.registrerCell()
    }
    
    func willFetchMovies() {
        interactor?.fetchMovies()
    }
}

extension TrendingPresenter: TrendingInteractorOutputProtocol {
    func onReceivedMovies(_ entity: TrendingEntity) {
        self.entity = entity
        self.view?.updateData(self.entity)
        self.view?.updataView()
    }
    
    func showMoviesError(_ error: Error) {
        print(error)
    }
}
