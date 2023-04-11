//
//  Presenter_Home.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 29/03/23.
//

import Foundation

class Presenter: ViewToPresenterProtocol, InteractorToPresenter {
    
    // MARK: Variables
    var interactor: PresenterToInteractor?
    var view: PresenterToViewProtocol?
    
    var movies: [Viewable] = [] {
        didSet {
            view?.reloadView()
        }
    }

    // MARK: HomeToViewProtocol Methods
    func getMoviesData() {
        interactor?.getMoviesData()
    }
    
    func getNumberOfItems() -> Int {
        return movies.count
    }
    
    func getCellText(index: IndexPath) -> String {
        return movies[index.row].getReleaseData()
    }
    
    // MARK: InteractorToPresenter Methods
    func manageResponse(results: [Viewable]) {
        movies = results
    }
}
