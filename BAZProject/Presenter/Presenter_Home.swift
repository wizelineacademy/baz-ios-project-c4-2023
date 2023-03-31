//
//  Presenter_Home.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 29/03/23.
//

import Foundation

protocol PresenterToInteractor {
    func getMoviesData()
}

protocol PresenterToViewProtocol {
    func reloadView()
}

class Presenter: HomeToViewProtocol, InteractorToPresenter {
    
    // MARK: Variables
    var interactor: PresenterToInteractor?
    var view: PresenterToViewProtocol?
    
    var movies: [Viewable] = []
    
    // MARK: HomeToViewProtocol Methods
    func getMoviesData() {
        interactor?.getMoviesData()
    }
    
    func getNumberOfItems() -> Int {
        return movies.count
    }
    
    func setModel(cell: MovieAppCollectionViewCell, index: IndexPath) -> MovieAppCollectionViewCell {
        cell.cellLabel.text = movies[index.row].getTitle()
        return cell
    }
    
    // MARK: InteractorToPresenter Methods
    func manageResponse(results: [Viewable]) {
        print(results)
        movies = results
        view?.reloadView()
    }
}
