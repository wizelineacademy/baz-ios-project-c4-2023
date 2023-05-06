//
//  DetailMovieInteractor.swift
//  BAZProject
//
//  Created by Ben Frank V. on 03/05/23.
//  
//

import Foundation

class DetailMovieInteractor: DetailMovieInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: DetailMovieInteractorOutputProtocol?
    var localDatamanager: DetailMovieLocalDataManagerInputProtocol?
    var remoteDatamanager: DetailMovieRemoteDataManagerInputProtocol?
    var entity: DetailMovieEntity?

    func fetchDetailsMovie(){
        guard let entity = self.entity, let baseInfo = entity.baseInfo else {return}
        remoteDatamanager?.getReviewsMovie(baseInfo.id)
    }
    
}

extension DetailMovieInteractor: DetailMovieRemoteDataManagerOutputProtocol {
    func handleGetReviewsMovie(_ result: [MovieReviews]) {
        entity?.reviews = result
        guard let entity = self.entity, let baseInfo = entity.baseInfo else {return}
        remoteDatamanager?.getCastingMovie(baseInfo.id)
    }
    
    func handleGetCreditsMovie(_ result: MovieCreditsResult) {
        entity?.credits = result
        entity?.casting = result.cast
        guard let entity = self.entity, let baseInfo = entity.baseInfo else {return}
        remoteDatamanager?.getGetMovieRecommendations(baseInfo.id)
    }
    
    func handleGetMovieRecommendations(_ result: [Movie]) {
        entity?.recomendations = result
        guard let entity = self.entity, let baseInfo = entity.baseInfo else {return}
        remoteDatamanager?.getGetSimilarMovies(baseInfo.id)
    }
    
    func handleGetSimilarMovies(_ result: [Movie]) {
        entity?.similarMovies = result
        Loader.stop()
        //TODO:llamar al presenter, para parar al spinner y regresar la info
    }
    
    func handleGetErrorServiceDetailMovies(_ error: Error) {
        DispatchQueue.main.async {
            Loader.stop()
        }
        
    }
    
    // TODO: Implement use case methods
}
