//
//  SearchInteractor.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 16/04/23.
//

import Foundation

public protocol SearchBusinessLogic {
    var presenter: SearchPresentationLogic? { get }
    
    func search(withParams strQuery: String?)
}

public class SearchInteractor {
    public var presenter: SearchPresentationLogic?
    public var networkingSearch: NetworkingProtocol?
    private var arrMovies: [Movie]?
    
    public init(presenter: SearchPresentationLogic? = nil, networkingSearch: NetworkingProtocol? = nil) {
        self.presenter = presenter
        self.networkingSearch = networkingSearch
    }
    
}

extension SearchInteractor: SearchBusinessLogic {
    public func search(withParams strQuery: String?) {
        guard let strQuery = strQuery, !strQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            presenter?.search(FailedWith: .invalidString)
            return
        }
        
        searchMovies(withParams: strQuery)
    }
    
    private func searchMovies(withParams strParams: String) {
        networkingSearch?.updatePath(with: .search(strQuery: strParams))
        networkingSearch?.search(withCompletionHandler: {[weak self] (result: Result<MovieService, ErrorApi>)  in
            switch result{
            case .success(let response):
                if let arrResponseMovies = response.results, arrResponseMovies.count > 0 {
                    self?.fillArrMovies(withResponse: arrResponseMovies)
                }else{
                    self?.presenter?.search(FailedWith: .noResultsFound)
                }
            case .failure(_):
                self?.presenter?.search(FailedWith: .serviceProblem)
            }
        })
    }
    
    private func fillArrMovies(withResponse arrResponse: [MovieDetailService]) {
        arrMovies = nil
        arrMovies = [Movie]()
        for response in arrResponse {
            if let movie = response.convertToMovieApp() {
                arrMovies?.append(movie)
            }
        }
        
        presenter?.searchDidBrougntResults(in: arrMovies ?? [Movie]())
    }
    
}
