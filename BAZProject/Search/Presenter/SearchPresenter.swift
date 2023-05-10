//
//  SearchPresenter.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//  
//

import Foundation
import UIKit

class SearchPresenter  {
    
    // MARK: Properties
    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorInputProtocol?
    var router: SearchRouterProtocol?
    
    var entity = SearchEntity()
    var tableView: UITableView = UITableView()
    
}

extension SearchPresenter: SearchPresenterProtocol {
    func viewDidLoad() {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        entity.result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: GeneralTableViewCell.identifier, for: indexPath) as? GeneralTableViewCell{
            let movie = entity.result?[indexPath.row]
            cell.setup(movie)
            return cell
        }else{
            let cell = UITableViewCell()
            return cell
        }
    }
    
    
    func willFetchMovies(_ movie: String) {
        interactor?.fetchMovies(movie)
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    
    func onReceivedSearchedMovies(_ result: [Movie]) {
        entity.result = result
        view?.updateData(result)
        
    }
    
    func showSearchedMoviesError(_ error: Error) {
        print(error)
    }
}
