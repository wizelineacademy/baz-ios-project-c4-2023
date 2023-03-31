//
//  TrendingPresenter.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 29/03/23.
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
    func viewDidLoad() {
        view?.setNavigationTitle(for: interactor?.getNavTitle())
        view?.registerXIB()
        interactor?.getMovies()
    }
    
    func getNumberOfRows() -> Int? {
        return interactor?.getNumberOfRows()
    }
    
    func getMovie(forRow iRow: Int) -> Movie? {
        return interactor?.getMovie(forRow: iRow)
    }
}

extension TrendingPresenter: TrendingInteractorOutputProtocol {
    func serviceRespondedSuccess() {
        view?.reloadTable()
    }
    
    func serviceFailed(withError error: ErrorApi) {
        router?.showAlert(withMessage: error.getMessage(), from: view)
    }
}
