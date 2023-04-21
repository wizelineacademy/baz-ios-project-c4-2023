//  SearchPresenter.swift
//  BAZProject
//
//  Created by jehernandezg on 20/04/23.

import Foundation

// MARK: - Class
class SearchPresenter {
    // MARK: - Properties
    weak var view: SearchViewInputProtocol?
    var interactor: SearchInteractorInputProtocol
    var router: SearchRouterProtocol
    
    init(view: SearchViewInputProtocol,
         interactor: SearchInteractorInputProtocol,
         router: SearchRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - Extensions

// MARK: - V I E W · T O · P R E S E N T E R
extension SearchPresenter: SearchViewOutputProtocol {
    
}

// MARK: - I N T E R A C T O R · T O · P R E S E N T E R
extension SearchPresenter: SearchInteractorOutputProtocol {

}
