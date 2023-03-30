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

class Presenter: HomeToViewProtocol {
    
    // MARK: Variables
    
    var interactor: PresenterToInteractor?
    
    // MARK: HomeToViewProtocol Methods
    func getMoviesData() {
        print("Aqui llega la petición de los datos, en una función del Presenter, para consumir el api TheMovieDB.")
        print("Desde el presenter se pide al Interactor que vaya a consultar TheMovieDB... llamando interactor.getMoviesData()")
        interactor?.getMoviesData()
    }
}
