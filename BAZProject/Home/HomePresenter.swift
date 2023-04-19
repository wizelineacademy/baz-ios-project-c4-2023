//  HomePresenter.swift
//  BAZProject
//
//  Created by jehernandezg on 18/04/23.
//  
//  ViperTemplate v.0.0.1 - (2023, NS-Bionick Development Team)

import UIKit

// MARK: - Class
class HomePresenter {
    // MARK: - Properties
    weak var view: HomeViewInputProtocol?
    var interactor: HomeInteractorInputProtocol
    var router: HomeRouterProtocol
    
    init(view: HomeViewInputProtocol,
         interactor: HomeInteractorInputProtocol,
         router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - Extensions

// MARK: - V I E W · T O · P R E S E N T E R
extension HomePresenter: HomeViewOutputProtocol {
    func getDataMovies(_ completion: @escaping () -> Void) {
        interactor.getDataMovies(completion)
    }
    
    func getMoviesCount() -> Int {
        interactor.getMoviesCount()
    }
    
    func getMovieDescription(index: Int) -> String? {
        interactor.getMovieDescription(index: index)
    }
    
    func getMovieImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        interactor.getMovieImage(index: index, completion: completion)
    }
    
    
}

// MARK: - I N T E R A C T O R · T O · P R E S E N T E R
extension HomePresenter: HomeInteractorOutputProtocol {
    var labelTitle: String {
        return interactor.labelTitle
    }
}


