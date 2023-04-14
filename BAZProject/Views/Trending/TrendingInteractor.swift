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
    var serviceApi: NetworkingProtocol?
    var entity: TrendingEntity?

    func getNavTitle() -> String? {
        return entity?.strNavBarTitle
    }
    
    func getMovies() {
        serviceApi?.search(withCompletionHandler: { [weak self] (result: Result<MovieService, ErrorApi>) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presenter?.serviceFailed(withError: error)
                }
            case .success(let movies):
                if let arrResponse = movies.results, arrResponse.count > 0{
                    self?.updateMovies(with: arrResponse)
                }
            }
        })
    }
    
    func getNumberOfRows() -> Int? {
        return entity?.getNumberOfRows()
    }
    
    func getMovie(forRow iRow: Int) -> Movie? {
        return entity?.getMovie(forRow: iRow)
    }
    
    private func updateMovies(with arrResponse: [MovieDetailService]) {
        var arrMovies: [Movie] = [Movie]()
        for movie in arrResponse {
            if let movie = movie.convertToMovieApp(){
                arrMovies.append(movie)
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.entity?.updateMovies(with: arrMovies)
            self?.presenter?.serviceRespondedSuccess()
        }
    }
    
}
