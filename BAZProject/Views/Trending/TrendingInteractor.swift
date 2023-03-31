//
//  TrendingInteractor.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 29/03/23.
//  
//

import Foundation

class TrendingInteractor: TrendingInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: TrendingInteractorOutputProtocol?
    var localDatamanager: TrendingLocalDataManagerInputProtocol?
    var remoteDatamanager: TrendingRemoteDataManagerInputProtocol?
    var entity: TrendingEntity?

    func getNavTitle() -> String?{
        return entity?.strNavBarTitle
    }
    
    func getMovies() {
        remoteDatamanager?.getMovies()
    }
    
    func getNumberOfRows() -> Int? {
        return entity?.getNumberOfRows()
    }
    
    func getMovie(forRow iRow: Int) -> Movie? {
        return entity?.getMovie(forRow: iRow)
    }
    
}

extension TrendingInteractor: TrendingRemoteDataManagerOutputProtocol {
    func moviesObtained(with arrMovies: [Movie]?) {
        entity?.updateMovies(with: arrMovies)
        presenter?.serviceRespondedSuccess()
    }
    
    func serviceDidFail(with error: ErrorApi) {
        presenter?.serviceFailed(withError: error)
    }
    
}
