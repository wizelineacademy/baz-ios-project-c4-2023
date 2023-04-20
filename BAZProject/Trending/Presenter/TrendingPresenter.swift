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
    
}

extension TrendingPresenter: TrendingPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
        view?.setNavigationTitle(for: interactor?.getNavTitle())
    }
}

extension TrendingPresenter: TrendingInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
