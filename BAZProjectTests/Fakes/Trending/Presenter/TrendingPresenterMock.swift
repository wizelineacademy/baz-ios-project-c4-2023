//
//  TrendingPresenterMock.swift
//  BAZProjectTests
//
//  Created by Ben Frank V. on 25/04/23.
//

import Foundation
import UIKit

class TrendingPresenterMock  {
    
    // MARK: Properties
    weak var view: TrendingViewProtocol?
    var interactor: TrendingInteractorInputProtocol?
    var router: TrendingRouterProtocol?
    
    var result: [Movie] = []
    
}

extension TrendingPresenterMock: TrendingPresenterProtocol {
    
    // TODO: implement presenter methods
    func viewDidLoad() {
        view?.setNavigationTitle(for: interactor?.getNavTitle())
        view?.registrerCell()
    }
    
    func willFetchMovies() {
        interactor?.fetchMovies()
    }
}

extension TrendingPresenterMock: TrendingInteractorOutputProtocol {
    func onReceivedMovies(_ result: [Movie]) {
        self.result = result
    }
    
    func showMoviesError(_ error: Error) {
        print(error)
    }
}
