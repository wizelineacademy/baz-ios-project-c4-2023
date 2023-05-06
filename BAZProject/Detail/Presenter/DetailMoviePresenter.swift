//
//  DetailMoviePresenter.swift
//  BAZProject
//
//  Created by Ben Frank V. on 03/05/23.
//  
//

import Foundation
import UIKit

class DetailMoviePresenter  {
    
    // MARK: Properties
    weak var view: DetailMovieViewProtocol?
    var interactor: DetailMovieInteractorInputProtocol?
    var router: DetailMovieRouterProtocol?
    var entity: DetailMovieEntity?
    
}

extension DetailMoviePresenter: DetailMoviePresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
        
    }
    
    func update() {
        guard let entity = self.entity, let movie = entity.baseInfo else {return}
        view?.getImage(movie.backdrop_path ?? "")
        view?.titleMovie(movie.title)
        view?.overview(movie.overview)
        view?.cast(entity.processedCast)
        
    }
    
    func willFetchDetailsMovie() {
        Loader.start()
        interactor?.fetchDetailsMovie()
    }
}

extension DetailMoviePresenter: DetailMovieInteractorOutputProtocol {
    func onReceivedMovieDetails(_ result: DetailMovieEntity) {
        self.entity = result
        update()
    }
    
    func showSearchedMoviesError(_ error: Error) {
       // <#code#>
    }
    
    // TODO: implement interactor output methods
}
