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
    
    var entity = TrendingEntity()
    
}

extension TrendingPresenterMock: TrendingPresenterProtocol {
    
    // TODO: implement presenter methods
    func viewDidLoad() {
        view?.registrerCell()
    }
    
    func willFetchMovies() {
        interactor?.fetchMovies()
    }
}

extension TrendingPresenterMock: TrendingInteractorOutputProtocol {
    func onReceivedMovies(_ entity: TrendingEntity) {
        self.entity = entity
    }
    
    func showMoviesError(_ error: Error) {
        print(error)
    }
}
