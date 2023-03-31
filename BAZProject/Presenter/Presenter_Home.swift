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
        print("Aqui llega la petición de los datos, en una función del Presenter, para consumir el api TheMovieDB.")
        print("Desde el presenter se pide al Interactor que vaya a consultar TheMovieDB... llamando interactor.getMoviesData()")
        interactor?.getMoviesData()
    }
    
    func getNumberOfItems() -> Int {
        print("Imprimiendo el número de Items desde el Presenter")
        return movies.count
    }
    
    func setModel(cell: MovieAppCollectionViewCell, index: IndexPath) -> MovieAppCollectionViewCell {
        cell.cellLabel.text = movies[index.row].getTitle()
        return cell
    }
    
    // MARK: InteractorToPresenter Methods
    func manageResponse(results: [Viewable]) {
        print("Estando en el Presenter se recibe la llamada desde el Interactor para manejar los datos")
        print("Lo que llega como datos se ve como:")
        print(results)
        movies = results
        view?.reloadView()
    }
}
