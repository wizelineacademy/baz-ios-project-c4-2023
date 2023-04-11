//
//  Protocols.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 10/04/23.
//

import Foundation

protocol ViewToPresenterProtocol {
    var interactor: PresenterToInteractor? { get set }
    
    func getMoviesData()
    func getNumberOfItems() -> Int
    func getCellText(index: IndexPath) -> String
}

protocol PresenterToViewProtocol {
    func reloadView()
}

protocol PresenterToInteractor {
    func getMoviesData()
}

protocol InteractorToPresenter {
    func manageResponse(results: [Viewable])
}
