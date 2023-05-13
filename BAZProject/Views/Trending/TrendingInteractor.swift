//
//  TrendingInteractor.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 29/03/23.
//  
//

import Foundation

public class TrendingInteractor: TrendingInteractorInputProtocol {

    // MARK: Properties
    weak public var presenter: TrendingInteractorOutputProtocol?
    public var serviceApi: NetworkingProtocol?
    public var entity: TrendingEntity?
    public var favorite: FavoriteSavingManager?
    
    public init(presenter: TrendingInteractorOutputProtocol? = nil, serviceApi: NetworkingProtocol? = nil, entity: TrendingEntity? = nil) {
        self.presenter = presenter
        self.serviceApi = serviceApi
        self.entity = entity
    }

    public func getNavTitle() -> String? {
        return entity?.strNavBarTitle
    }
    
    public func getMovies(withFilter filter: Paths?) {
        if let filter = filter {
            getMoviesInWeb(withFilter: filter)
        } else {
            getFavorites()
        }
    }
    
    private func getMoviesInWeb(withFilter filter: Paths) {
        serviceApi?.updatePath(with: filter)
        serviceApi?.search(withCompletionHandler: { [weak self] (result: Result<MovieService<MovieDetailService>, ErrorApi>) in
            switch result {
            case .failure(let error):
                self?.presenter?.serviceFailed(withError: error)
            case .success(let movies):
                if let arrResponse = movies.results, arrResponse.count > 0 {
                    self?.updateMovies(with: arrResponse)
                }
            }
        })
    }
    
    private func getFavorites() {
        if let arrMovies = favorite?.getMovies() {
            handleSuccess(for: arrMovies)
        }
    }
    
    public func getNumberOfRows() -> Int? {
        return entity?.getNumberOfRows()
    }
    
    public func getMovie(forRow iRow: Int) -> Movie? {
        return entity?.getMovie(forRow: iRow)
    }
    
    private func updateMovies(with arrResponse: [MovieDetailService]) {
        var arrMovies: [Movie] = [Movie]()
        for movie in arrResponse {
            if let movie = movie.convertToMovieApp(){
                arrMovies.append(movie)
            }
        }
        handleSuccess(for: arrMovies)
    }
    
    private func handleSuccess(for arrMovies: [Movie]) {
        entity?.updateMovies(with: arrMovies)
        presenter?.serviceRespondedSuccess()
    }
    
}
